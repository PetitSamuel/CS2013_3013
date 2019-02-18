import os

import passlib.pwd
from flask import Flask, request, jsonify, render_template
from flask_restful import Api
from healthcheck import HealthCheck

from resources import auth
from models import db, validation, User, full_user_schema

app = Flask(__name__)

# Configuration is provided through environment variables by Docker Compose
app.config.update({
    'SQLALCHEMY_TRACK_MODIFICATIONS': False,
    'SQLALCHEMY_DATABASE_URI': 'mysql+mysqlconnector://{user}:{password}@{host}/{database}'.format(
        user = os.environ['MYSQL_USER'],
        password = os.environ['MYSQL_PASSWORD'],
        host = os.environ['MYSQL_HOST'],
        database = os.environ['MYSQL_DATABASE']
    ),
    'SECRET_KEY': os.environ['FLASK_SECRET'],
    'JWT_SECRET_KEY': os.environ['JWT_SECRET'],
    'JWT_BLACKLIST_ENABLED': True,
    'JWT_BLACKLIST_TOKEN_CHECKS': ['access', 'refresh'],
    'JWT_ACCESS_TOKEN_EXPIRES': int(os.environ['JWT_ACCESS_EXPIRY']),
    'JWT_REFRESH_TOKEN_EXPIRES': int(os.environ['JWT_REFRESH_EXPIRY'])
})

@app.errorhandler(404)
def not_found(e):
    if request.path.startswith('/api/v1'):
        return jsonify({'message': 'Not found'}), 404

    return render_template('404.html'), 404

api = Api(app, prefix='/api/v1')
db.init_app(app)
auth.jwt.init_app(app)
validation.init_app(app)

def db_ok():
    return User.query.count() >= 0, "database ok"
health = HealthCheck(app, '/health')
health.add_check(db_ok)

# Mount our API endpoints
#api.add_resource(auth.Registration, '/auth/register')
api.add_resource(auth.Login, '/auth/login')
api.add_resource(auth.Token, '/auth/token')
api.add_resource(auth.Access, '/auth/access')

@app.before_first_request
def create_tables():
    # Create the tables (does nothing if they already exist)
    db.create_all()

    # Create the default `root` user if they don't exist
    root = User.find_by_username('root')
    if not root:
        root = User()
        password = passlib.pwd.genword(entropy=256)
        full_user_schema.load({
            'username': 'root',
            'password': password,
            'is_approved': True,
            'is_admin': True
        }, instance=root)

        db.session.add(root)
        db.session.commit()

        print('**** ROOT USER CREATED ****')
        print('PASSWORD: {}'.format(password))

if __name__ == "__main__":
    # If we are started directly, run the Flask development server
    app.run(host='0.0.0.0', port=8080)

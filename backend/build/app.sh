#!/bin/sh
# main application entrypoint

if [ "$FLASK_ENV" == "development" ]; then
	# use flask debug server in development
	exec python /opt/app/briefthreat.py
else
	# use gunicorn in production
	exec gunicorn --workers $GUNICORN_WORKERS --bind :8080 --chdir /opt/app --user nobody --group nogroup briefthreat:app
fi

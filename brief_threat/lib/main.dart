import 'package:flutter/material.dart';
import 'FormScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Form app',  // someone please suggest something :)
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _user = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text('Welcome !',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ],
                ),
                SizedBox(height: 120.0),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Username",
                    filled: true,
                  ),
                  controller: _userNameController,
                ),
                SizedBox(height: 12.0), //spacer
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Login'),
                      onPressed: () async {
                        // trim user name but not password
                        _user = _userNameController.text.trim();
                        _password = _passwordController.text;

                        if (_user.isEmpty || _password.isEmpty) {
                          showSnackBarErrorMessage(_scaffoldKey, "Please fill in all fields");
                          return;
                        }

                        // show loading snack bar
                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(
                                content: new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Signing-In...")
                                ],
                              ),
                              ));
                        _loginPressed();


                        // TODO implement this when we have the login system setup
                        /*
                        showSnackBarErrorMessage(_scaffoldKey, "Incorrect username or password. Please try again");
                        return;
                        */

                        // wait before loading new page
                        // TODO remove when login is implemented with backend
                        await new Future.delayed(const Duration(seconds: 3));

                        // redirect to new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FormScreen()),
                        );

                      },
                    )
                  ],
                )

              ],
            )
        )
    );
  }

  // handle login, currently just prints what was entered in the text fields
  void _loginPressed () {
    print('The user wants to login with $_user and $_password');
  }

  void showSnackBarErrorMessage (GlobalKey<ScaffoldState> _scaffoldKey, String message) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          duration: Duration(seconds: 3),
          content: new Row(
            children: <Widget>[
              new Text(message)
            ],
          ),
        ));
  }
}

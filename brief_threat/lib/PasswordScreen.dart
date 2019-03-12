import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  @override
  State createState() => _PasswordScreen();
}

class _PasswordScreen extends State <PasswordScreen> {
// text input controllers & variables
  final TextEditingController _userNameController = new TextEditingController();
  String _user = "";
  static final GlobalKey<ScaffoldState> _second = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _second,
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text('Reset Your Password',
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
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        _user =_userNameController.text;
                        // handle backend call here
                        print("sent request to access : $_user");
                      },
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}
import 'package:flutter/material.dart';
// different types of dialogs needed in this application

// shows a dialog with a title, message and a close button
void showMessageDialog(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// shows a dialog to handle successful form submission by a user
void showFormSuccessDialog(int id, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Success"),
        content: new Text("The form has been sent successfully! id: $id"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// shows dialog (admin only) requesting to validate the approval of a form
void adminValidateRequestDialog(int id, BuildContext context, Function handleApproveRequest) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Do you want to validate this request?"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Validate"),
            onPressed: () {
              Navigator.of(context).pop();
              handleApproveRequest(id);
            },
          ),
          new FlatButton(
            child: new Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// dialog used for logging out a user (confirm logout)
void showLogOutConfirmationDialog(BuildContext context, Function logout) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Do you want to log out ?"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Confirm"),
            onPressed: () {
              Navigator.of(context).pop();
              logout();
            },
          ),
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

void DialogButton(BuildContext context, String title, String content, Function callback) {
  title = "Confirm " + title;
  content = "Are you sure you want to " + content;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
          new FlatButton(
            child: new Text("Confirm"),
            onPressed: () {
              Navigator.of(context).pop();
              callback();
            }
          ),
        ],
      );
    }
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void asdfsafd(BuildContext context, String title, String content) {
  title = "Confirm " + title;
  content = "Are you sure you want to ";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Confirm"),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
        ],
      );
    }
  );
}
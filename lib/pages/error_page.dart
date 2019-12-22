import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final void Function() onPressed;

  ErrorPage({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Browser"),
      ),
      body: Center(
        child: RaisedButton.icon(
          icon: Icon(Icons.refresh),
          label: Text("Some Error Occurred"),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

Future<dynamic> LoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Container(
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      );
    },
  );
}

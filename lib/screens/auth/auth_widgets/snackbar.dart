import 'package:flutter/material.dart';

class AuthenticationSnackBar extends StatelessWidget {
  const AuthenticationSnackBar({Key? key, required this.message})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
  }
}

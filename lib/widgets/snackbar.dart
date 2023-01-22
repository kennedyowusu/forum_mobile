import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({Key? key, required this.message})
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
      backgroundColor: primary,
      duration: Duration(seconds: 3),
    );
  }
}

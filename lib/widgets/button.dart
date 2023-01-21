import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  final String buttonText;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.05),
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

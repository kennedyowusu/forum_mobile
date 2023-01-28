import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.inputController,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController inputController;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 2,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: inputController,
        obscureText: obscureText ? true : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

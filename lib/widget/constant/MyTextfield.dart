import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  TextInputType keyboardType;
  String hintText;
  bool obscureText;
  Icon suffixIcon;
TextEditingController control; 
  MyTextfield({
    required this.control,
    required this.keyboardType,
    required this.hintText,
    required this.obscureText,
    required this.suffixIcon,
    
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: control,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: suffixIcon,
          filled: true,
        ),
      ),
    );
  }
}

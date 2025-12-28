import 'package:flutter/material.dart';
import 'package:homekru_owner/core/theme/theme_helper.dart';

class AuthCustomTextField extends StatelessWidget {
  const AuthCustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
  });

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: appTheme.lightGrey,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: appTheme.lightGrey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appTheme.veryLightGrey),
        ),
      ),
      validator: validator,
    );
  }
}

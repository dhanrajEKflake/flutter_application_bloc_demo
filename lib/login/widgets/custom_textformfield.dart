import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color hintTextColor;
  final Color textColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.grey,
    this.hintTextColor = Colors.grey,
    this.textColor = Colors.black,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintStyle: TextStyle(color: hintTextColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      style: TextStyle(color: textColor),
    );
  }
}

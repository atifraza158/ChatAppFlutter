import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? ketboardType;
  final String? hintText;
  final Widget? icon;
  final String? Function(String?)? validate;
  final bool obsecureText;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    this.icon,
    required this.controller,
    this.ketboardType,
    this.hintText,
    required this.validate,
    required this.obsecureText,
    this.maxLength,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      controller: controller,
      keyboardType: ketboardType,
      cursorColor: AppColors.themeColor,
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
        suffixIcon: icon,
        focusColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColors.themeColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColors.red,
            )),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.greyColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColors.themeColor,
            )),
      ),
      validator: validate,
    );
  }
}

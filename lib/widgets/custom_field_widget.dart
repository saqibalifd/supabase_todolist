import 'package:flutter/material.dart';
import 'package:supabasetodolist/constant/app_colors.dart';

class CustomFieldWidget extends StatelessWidget {
  final String text;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  CustomFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.primaryColor,
          hintText: text,
          hintStyle: TextStyle(fontSize: 13),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabasetodolist/constant/app_colors.dart';

class MainButtonWidget extends StatelessWidget {
  String text;

  bool? isLoading;
  final VoidCallback ontap;
  MainButtonWidget({
    super.key,
    required this.text,

    required this.ontap,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.buttonBackGround),
          child: Center(
            child: isLoading == true
                ? CircularProgressIndicator(color: AppColors.primaryColor)
                : Text(
                    text,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

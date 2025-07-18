// ignore_for_file: file_names, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabasetodolist/constant/app_colors.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/auth_provider.dart';
import 'package:supabasetodolist/widgets/custom_field_widget.dart';
import 'package:supabasetodolist/widgets/main_button_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailControler = TextEditingController();
    TextEditingController _passwordControler = TextEditingController();
    AuthProvider authProvider = context.read<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                /// first sized box
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20.h),

                CustomFieldWidget(
                  text: 'Enter your email ',
                  controller: _emailControler,
                ),

                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget Password!',
                      style: TextStyle(
                        color: AppColors.buttonBackGround,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Consumer<AuthProvider>(
                  builder: (context, provider, child) => MainButtonWidget(
                    text: "Forgot",
                    isLoading: provider.isLoading,
                    ontap: () {
                      // provider.for(context, _emailControler.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

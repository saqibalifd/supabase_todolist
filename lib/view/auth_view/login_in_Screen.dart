// ignore_for_file: file_names, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabasetodolist/constant/app_colors.dart';
import 'package:supabasetodolist/constant/app_images.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/auth_provider.dart';
import 'package:supabasetodolist/view/auth_view/forget_password_screen.dart';
import 'package:supabasetodolist/view/auth_view/signup_screen.dart';
import 'package:supabasetodolist/widgets/custom_field_widget.dart';
import 'package:supabasetodolist/widgets/main_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 20.h),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Let’s help you meet your tasks',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),

                Image.asset(AppImages.loginImage),
                SizedBox(height: 20.h),

                CustomFieldWidget(
                  text: 'Enter your email ',

                  controller: _emailControler,
                ),

                SizedBox(height: 20.h),
                CustomFieldWidget(
                  text: 'Enter your password',

                  controller: _passwordControler,
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
                    text: "Login",
                    isLoading: provider.isLoading,
                    ontap: () {
                      provider.signIn(
                        context,
                        _emailControler.text.trim(),
                        _passwordControler.text,
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account ?'),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.buttonBackGround,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

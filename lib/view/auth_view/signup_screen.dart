// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:supabasetodolist/constant/app_colors.dart';
import 'package:supabasetodolist/provider/feature_provider.dart/auth_provider.dart';
import 'package:supabasetodolist/view/auth_view/login_in_Screen.dart';
import 'package:supabasetodolist/widgets/custom_field_widget.dart';
import 'package:supabasetodolist/widgets/main_button_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailControler = TextEditingController();
    TextEditingController nameControler = TextEditingController();
    TextEditingController passwordControler = TextEditingController();
    TextEditingController ConfromControler = TextEditingController();
    // final authProvider = context.read<AuthProvider>;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10.h,
                children: [
                  /// first sized box
                  Text(
                    'Welcome onboard!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),

                  /// second sized box
                  Text(
                    'Let’s help you meet your tasks',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),

                  CustomFieldWidget(
                    text: 'Enter your full name ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },

                    controller: nameControler,
                  ),

                  /// sized box
                  SizedBox(height: 20.h),
                  CustomFieldWidget(
                    text: 'Enter your email ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },

                    controller: emailControler,
                  ),

                  /// sized box
                  SizedBox(height: 20.h),
                  CustomFieldWidget(
                    text: 'Enter password ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be minimum 6 char';
                      }
                      return null;
                    },

                    controller: passwordControler,
                  ),

                  /// sized box
                  SizedBox(height: 20.h),
                  CustomFieldWidget(
                    text: 'Confrom password',

                    controller: ConfromControler,
                  ),
                  // sized box
                  SizedBox(height: 10.h),
                  Consumer<AuthProvider>(
                    builder: (context, provider, child) => MainButtonWidget(
                      text: "Register",
                      isLoading: provider.isLoading,
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          print('button is pressed');
                          provider.signUp(
                            context,
                            nameControler.text.toString(),
                            emailControler.text.toString(),
                            passwordControler.text.toString(),
                            ConfromControler.text.toString(),
                          );
                        }
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account ?'),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                        child: Text(
                          'Sign In',
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
      ),
    );
  }
}

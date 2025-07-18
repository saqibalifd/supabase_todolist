// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabasetodolist/constant/app_images.dart';
import 'package:supabasetodolist/view/auth_view/login_in_Screen.dart';
import 'package:supabasetodolist/widgets/main_button_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 60.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.splashImage),

            Text(
              'Get things done with TODo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "We believe that this will become,youre's best Reminder and Pocket diary",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),

            MainButtonWidget(
              text: 'Get Started',

              ontap: () {
                debugPrint("user click on splash screen button");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

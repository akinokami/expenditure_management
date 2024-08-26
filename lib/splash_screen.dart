import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenController = Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFf7f7f7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/logo.png',
              width: 100.w,
              height: 100.h,
            ),
            kSizedBoxH30,
            CircularProgressIndicator(
              color: secondaryColor,
            ),
            kSizedBoxH30,
            CustomText(text: 'please_wait'.tr, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

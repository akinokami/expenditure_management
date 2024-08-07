import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenController = Get.put(SplashScreenController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100.0),
            kSizedBoxH30,
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            kSizedBoxH30,
            CustomText(text: 'please_wait'.tr, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

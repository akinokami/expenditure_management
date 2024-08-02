import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../bottom_navigation_menu.dart';
import '../../custom_widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.webp',
              width: 70.h,
              height: 70.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              text: 'Expenditure Management',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              image: 'assets/images/google.webp',
              text: 'Contine with google',
              bgColor: Colors.white,
              txtColor: Colors.black,
              onTap: () {
                Get.to(() => BottomNavigationMenu());
              },
            ),
          ],
        ),
      ),
    );
  }
}

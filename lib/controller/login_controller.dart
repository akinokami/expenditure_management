import 'package:expenditure_management/bottom_navigation_menu.dart';
import 'package:expenditure_management/services/google_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    //
    super.onInit();
  }

  void loginWithGoogle() async {
    try {
      final user = await GoogleApi.loginWithGoogle();
      print(user);
      if (user != null) {
        Get.offAll(() => BottomNavigationMenu());
      }
    } catch (e) {
      constants.showSnackBar(
          title: 'error'.tr, msg: e.toString(), textColor: Colors.red);
    }
  }
}

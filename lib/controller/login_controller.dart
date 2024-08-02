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
        Get.to(() => BottomNavigationMenu());
      }
    } catch (e) {
      Get.to(() => BottomNavigationMenu());
      print(e);
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    }
  }
}

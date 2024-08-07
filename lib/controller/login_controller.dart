import 'package:expenditure_management/bottom_navigation_menu.dart';
import 'package:expenditure_management/services/google_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants.dart';
import '../utils/global.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    //
    super.onInit();
  }

  void loginWithGoogle() async {
    isLoading.value = false;
    try {
      final user = await GoogleApi.loginWithGoogle();
      final box = GetStorage();

      if (user != null) {
        box.write('uid', user.uid);
        box.write('name', user.displayName);
        box.write('email', user.email);
        box.write('photo', user.photoURL);

        Global.uid = user.uid;
        Global.name = user.displayName ?? '';
        Global.email = user.email ?? '';
        Global.photo = user.photoURL ?? '';

        Get.offAll(() => BottomNavigationMenu());
      }
    } catch (e) {
      constants.showSnackBar(
          title: 'error'.tr, msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:expenditure_management/services/google_api.dart';
import 'package:expenditure_management/views/login/login_screen.dart';
import 'package:get/get.dart';

import '../bottom_navigation_menu.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      if (GoogleApi.user != null) {
        Get.offAll(() => BottomNavigationMenu());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  @override
  void dispose() {
    //
    super.dispose();
  }
}

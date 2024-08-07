import 'package:expenditure_management/utils/global.dart';
import 'package:expenditure_management/views/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../bottom_navigation_menu.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Global.uid = user.uid;
        Global.name = user.displayName ?? '';
        Global.email = user.email ?? '';
        Global.photo = user.photoURL ?? '';
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

import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firestore_service.dart';
import '../utils/constants.dart';

class ProfileController extends GetxController {
  final isLoading = false.obs;
  final firestoreService = FireStoreService();
  RxDouble sliderValue = 0.0.obs;

  @override
  void onInit() {
    //
    super.onInit();
  }

  void deleteAllUserData({required String docId}) {
    isLoading(true);
    try {
      firestoreService.deleteAll();
      Get.offAll(() => const LoginScreen());
      constants.showSnackBar(
          title: 'success'.tr,
          msg: 'deleted_all_user_data'.tr,
          textColor: secondaryColor);
    } catch (e) {
      constants.showSnackBar(
          title: 'error'.tr, msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void setSliderValue(double value) {
    sliderValue.value = value;
  }

  String get formattedTime {
    int totalMinutes = sliderValue.value.toInt();
    int hour = totalMinutes ~/ 60;
    int minute = totalMinutes % 60;
    return hour.toString().padLeft(2, '0') +
        ":" +
        minute.toString().padLeft(2, '0');
  }
}

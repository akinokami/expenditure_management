import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/global.dart';

class LanguageController extends GetxController {
  final language = ''.obs;

  final isLoading = false.obs;
  @override
  void onInit() {
    getLanguage();
    super.onInit();
  }

  void changeLanguage(String languageCode, String countryCode) {
    isLoading.value = true;
    language.value = languageCode;
    Global.language = languageCode;
    Get.updateLocale(Locale(languageCode, countryCode));
    final box = GetStorage();
    box.write('language', languageCode);

    Future.delayed(const Duration(milliseconds: 300), () {
      isLoading.value = false;
    });
  }

  void getLanguage() {
    final box = GetStorage();
    language.value = box.read('language') ?? 'en';
  }
}

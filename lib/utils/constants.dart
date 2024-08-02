import 'package:flutter/material.dart';
import 'package:get/get.dart';

Constants constants = Constants();

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();
  void showSnackBar(
      {String? title, String? msg, Color? bgColor, Color? textColor}) {
    Get.snackbar(
      title ?? "",
      msg ?? "",
      colorText: textColor ?? Colors.black,
      backgroundColor: bgColor ?? Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}

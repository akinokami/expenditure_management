import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controller/language_controller.dart';
import '../../custom_widgets/custom_text.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'change_language'.tr,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          )),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("en", "US");
                      },
                      child: Card(
                        color: lightWhiteColor,
                        child: ListTile(
                          leading: Image.asset(
                            "assets/images/usa.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          title: CustomText(
                            text: "English",
                            color: Colors.black,
                          ),
                          trailing: Icon(
                            languageController.language.value == "en"
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value == "en"
                                ? secondaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Obx(
                  //   () => GestureDetector(
                  //     onTap: () {
                  //       languageController.changeLanguage("zh", "CN");
                  //     },
                  //     child: Card(
                  //       color: cardColor,
                  //       child: ListTile(
                  //         leading: Image.asset(
                  //           "assets/images/china.webp",
                  //           width: 20.w,
                  //           height: 20.h,
                  //         ),
                  //         title: CustomText(
                  //           text: "中国人",
                  //           color: lightWhiteColor,
                  //         ),
                  //         trailing: Icon(
                  //           languageController.language.value == "zh"
                  //               ? Icons.check_circle
                  //               : Icons.check_circle_outline,
                  //           color: languageController.language.value == "zh"
                  //               ? secondaryColor
                  //               : lightWhiteColor,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("vi", "VN");
                      },
                      child: Card(
                        color: lightWhiteColor,
                        child: ListTile(
                          leading: Image.asset(
                            "assets/images/vietnam.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          title: CustomText(
                            text: "Tiếng Việt",
                            color: Colors.black,
                          ),
                          trailing: Icon(
                            languageController.language.value == "vi"
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value == "vi"
                                ? secondaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  // MaterialButton(onPressed: (){},child: Text("Save",style: TextStyle(color: lightWhiteColor),),color: secondaryColor,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                  // kSizedBoxH10
                ],
              ),
            ),
            languageController.isLoading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black
                        .withOpacity(0.5), // Semi-transparent overlay
                    child: Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ), // Loading indicator
                    ),
                  )
                : const SizedBox
                    .shrink(), // If not loading, don't show anything
          ],
        ),
      ),
    );
  }
}

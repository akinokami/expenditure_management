import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/controller/language_controller.dart';
import 'package:expenditure_management/controller/profile_controller.dart';
import 'package:expenditure_management/custom_widgets/custom_button.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/views/profile/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final languageController = Get.put(LanguageController());
    void _shareAppLink() {
      const String appLink = 'https://yourapp.link';
      Share.share('Check out this amazing app: $appLink');
    }

    void _showPersistentBottomSheet(BuildContext context) {
      showBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            height: 200.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Obx(() => CustomText(
                        text:
                            'Selected Time: ${profileController.formattedTime}',
                        color: primaryColor,
                        fontSize: 16.sp,
                      )),
                  Obx(() => Slider(
                        activeColor: secondaryColor,
                        inactiveColor: secondaryColor,
                        value: profileController.sliderValue.value,
                        min: 0,
                        max: 1439, // 24 hours * 60 minutes - 1
                        divisions: 1439,
                        label: profileController.formattedTime,
                        onChanged: (v) {
                          profileController.setSliderValue(v);
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        outlineColor: primaryColor,
                        text: 'cancel'.tr,
                        bgColor: redColor,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        width: 100.w,
                      ),
                      CustomButton(
                          outlineColor: primaryColor,
                          bgColor: secondaryColor,
                          text: 'save'.tr,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          width: 100.w)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: ListTile(
                leading: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                        child: CustomText(
                      text: "N",
                      fontSize: 16.sp,
                    )),
                  ),
                ),
                title: Text(
                  'Nguyễn Văn A',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                kSizedBoxH20,
                Card(
                  surfaceTintColor: primaryColor,
                  color: primaryColor,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: _shareAppLink,
                        leading: Icon(Icons.mobile_screen_share_outlined),
                        title: CustomText(
                          text: 'Recommend app to friends',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                      Divider(
                        color: greyColor,
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(() => const ChangeLanguageScreen());
                        },
                        leading: Icon(Icons.language),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'language'.tr,
                            ),
                            CustomText(
                              text: languageController.language.value == "vi"
                                  ? 'vietnam'.tr
                                  : 'english'.tr,
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(
                        color: greyColor,
                      ),
                      ListTile(
                        onTap: () {
                          _showPersistentBottomSheet(context);
                        },
                        leading: Icon(Icons.watch_later_outlined),
                        title: CustomText(
                          text: 'Daily reminder',
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                kSizedBoxH20,
                Card(
                  surfaceTintColor: primaryColor,
                  color: primaryColor,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete_outline, color: redColor),
                        title: CustomText(
                          text: 'delete_all_data'.tr,
                          color: redColor,
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: redColor),
                      ),
                      Divider(
                        color: greyColor,
                      ),
                      ListTile(
                        leading: Icon(Icons.logout_outlined, color: redColor),
                        title: CustomText(
                          text: 'sign_out'.tr,
                          color: redColor,
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: redColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

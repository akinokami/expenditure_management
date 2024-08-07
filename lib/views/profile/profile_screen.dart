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
import '../../services/google_api.dart';
import '../../utils/global.dart';

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
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.network(G),
                  ),
                ),
                title: Text(
                  Global.name,
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
                        leading: Icon(
                          Icons.mobile_screen_share_outlined,
                          size: 20.sp,
                        ),
                        title: CustomText(
                          text: 'recommend_app_to_friends'.tr,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        ),
                      ),
                      Divider(
                        color: greyColor,
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(() => const ChangeLanguageScreen());
                        },
                        leading: Icon(
                          Icons.language,
                          size: 20.sp,
                        ),
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
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        ),
                      ),
                      // Divider(
                      //   color: greyColor,
                      // ),
                      // ListTile(
                      //   onTap: () {
                      //     _showPersistentBottomSheet(context);
                      //   },
                      //   leading: Icon(
                      //     Icons.watch_later_outlined,
                      //     size: 20.sp,
                      //   ),
                      //   title: CustomText(
                      //     text: 'daily_reminder'.tr,
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios,
                      //     size: 20.sp,
                      //   ),
                      // ),
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
                        onTap: () {
                          Get.defaultDialog(
                              title: 'delete_all_data'.tr,
                              middleText:
                                  'are_you_sure_to_delete_all_expenditure_data'
                                      .tr,
                              titlePadding: EdgeInsets.all(10.h),
                              contentPadding: EdgeInsets.all(10.h),
                              backgroundColor: Colors.white,
                              titleStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                              middleTextStyle: TextStyle(
                                  color: Colors.black, fontSize: 12.sp),
                              textConfirm: 'confirm'.tr,
                              textCancel: 'cancel'.tr,
                              cancelTextColor: secondaryColor,
                              confirmTextColor: Colors.white,
                              buttonColor: secondaryColor,
                              barrierDismissible: false,
                              radius: 10,
                              onConfirm: () {
                                profileController.deleteAllUserData(
                                    docId: Global.uid);
                              });
                        },
                        leading: Icon(
                          Icons.delete_outline,
                          color: redColor,
                          size: 20.sp,
                        ),
                        title: CustomText(
                          text: 'delete_all_data'.tr,
                          color: redColor,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: redColor,
                          size: 20.sp,
                        ),
                      ),
                      Divider(
                        color: greyColor,
                      ),
                      ListTile(
                        onTap: () {
                          GoogleApi().logout();
                        },
                        leading: Icon(
                          Icons.logout_outlined,
                          color: redColor,
                          size: 20.sp,
                        ),
                        title: CustomText(
                          text: 'sign_out'.tr,
                          color: redColor,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: redColor,
                          size: 20.sp,
                        ),
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

import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_button.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/services/category_data.dart';
import 'package:expenditure_management/services/payment_method_data.dart';
import 'package:expenditure_management/utils/constants.dart';
import 'package:expenditure_management/utils/global.dart';
import 'package:expenditure_management/views/calendar/calendar_screen.dart';
import 'package:expenditure_management/views/home/home_screen.dart';
import 'package:expenditure_management/views/profile/profile_screen.dart';
import 'package:expenditure_management/views/statistical/statistical_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'constants/color_const.dart';
import 'controller/bottom_nav_controller.dart';

class BottomNavigationMenu extends StatelessWidget {
  BottomNavigationMenu({super.key});

  final TextStyle unselectedLabelStyle =
      TextStyle(color: greyColor, fontWeight: FontWeight.w500, fontSize: 11.sp);

  final TextStyle selectedLabelStyle = TextStyle(
      color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 11.sp);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 55.h,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            unselectedItemColor: greyColor.withOpacity(0.7),
            selectedItemColor: secondaryColor,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 18.w,
                ),
                label: 'home'.tr,
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.pie_chart,
                  size: 18.w,
                ),
                label: 'statistical'.tr,
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  size: 18.w,
                ),
                label: 'calendar'.tr,
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 18.w,
                ),
                label: 'profile'.tr,
                backgroundColor: primaryColor,
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController(), permanent: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        bottomNavigationBar:
            buildBottomNavigationMenu(context, bottomNavController),
        body: Obx(() => IndexedStack(
              index: bottomNavController.tabIndex.value,
              children: [
                HomeScreen(),
                StatisticalHomeScreen(),
                // ExpenditureCalendar(userId: GoogleApi.user?.uid ?? ''),
                CalendarScreen(),
                ProfileScreen(),
              ],
            )),
        floatingActionButton: Obx(
          () => bottomNavController.tabIndex.value == 0
              ? FloatingActionButton(
                  backgroundColor: secondaryColor,
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: primaryColor,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.9,
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            bottomNavController.changeExpense();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 15.w),
                                            decoration: BoxDecoration(
                                              color: bottomNavController
                                                      .isExpense.value
                                                  ? secondaryColor
                                                  : cardColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
                                            child: CustomText(
                                              text: 'expense'.tr,
                                              fontSize: 14.sp,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(() => GestureDetector(
                                            onTap: () {
                                              bottomNavController
                                                  .changeExpense();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 15.w),
                                              decoration: BoxDecoration(
                                                  color: bottomNavController
                                                          .isExpense.value
                                                      ? cardColor
                                                      : secondaryColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: CustomText(
                                                text: 'income'.tr,
                                                fontSize: 14.sp,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(height: 10.h),
                                  TextField(
                                    controller:
                                        bottomNavController.amountTxtController,
                                    maxLength: 15,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: cardColor,
                                      suffixText: "\u20AB",
                                      label: CustomText(
                                        text: 'amount'.tr,
                                        color: greyColor,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: 10.h),
                                  TextField(
                                    controller:
                                        bottomNavController.noteTxtController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: cardColor,
                                      label: CustomText(
                                        text: 'note'.tr,
                                        color: greyColor,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  kSizedBoxH10,
                                  ExpansionTile(
                                      backgroundColor: cardColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      collapsedBackgroundColor: cardColor,
                                      collapsedShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      title: CustomText(text: 'category'.tr),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: SizedBox(
                                            height: 300.h,
                                            child: GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: categoryList.length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio: 3,
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 20.w,
                                                        mainAxisSpacing: 10.h),
                                                itemBuilder: (context, index) {
                                                  return Obx(
                                                    () => GestureDetector(
                                                      onTap: () {
                                                        bottomNavController
                                                            .selectedCategory
                                                            .value = index;
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(2.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: bottomNavController
                                                                      .selectedCategory
                                                                      .value ==
                                                                  index
                                                              ? secondaryColor
                                                              : greyColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        child: Center(
                                                          child: CustomText(
                                                            text: Global.language ==
                                                                    'vi'
                                                                ? categoryList[
                                                                            index]
                                                                        .nameVn ??
                                                                    ""
                                                                : categoryList[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                            fontSize: 10.sp,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        )
                                      ]),
                                  kSizedBoxH10,
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: CustomText(
                                              text: Global.language == 'vi'
                                                  ? categoryList[bottomNavController
                                                              .selectedCategory
                                                              .value]
                                                          .nameVn ??
                                                      ""
                                                  : categoryList[bottomNavController
                                                              .selectedCategory
                                                              .value]
                                                          .name ??
                                                      "",
                                              fontSize: 10.sp,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  kSizedBoxH10,
                                  ExpansionTile(
                                      backgroundColor: cardColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      collapsedBackgroundColor: cardColor,
                                      collapsedShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      title:
                                          CustomText(text: 'payment_method'.tr),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: SizedBox(
                                            height: 100.h,
                                            child: GridView.builder(
                                                itemCount: paymentList.length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio: 3,
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 20.w,
                                                        mainAxisSpacing: 10.h),
                                                itemBuilder: (context, index) {
                                                  return Obx(
                                                    () => GestureDetector(
                                                      onTap: () {
                                                        bottomNavController
                                                            .selectedPayment
                                                            .value = index;
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(2.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: bottomNavController
                                                                      .selectedPayment
                                                                      .value ==
                                                                  index
                                                              ? secondaryColor
                                                              : greyColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        child: Center(
                                                          child: CustomText(
                                                            text: Global.language ==
                                                                    'vi'
                                                                ? paymentList[
                                                                            index]
                                                                        .nameVn ??
                                                                    ""
                                                                : paymentList[
                                                                            index]
                                                                        .name ??
                                                                    "",
                                                            fontSize: 10.sp,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        )
                                      ]),
                                  kSizedBoxH10,
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100.w,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: CustomText(
                                              text: Global.language == 'vi'
                                                  ? paymentList[bottomNavController
                                                              .selectedPayment
                                                              .value]
                                                          .nameVn ??
                                                      ""
                                                  : paymentList[bottomNavController
                                                              .selectedPayment
                                                              .value]
                                                          .name ??
                                                      "",
                                              fontSize: 10.sp,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  kSizedBoxH10,
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              size: 20.sp,
                                            ),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () => bottomNavController
                                                    .selectDate(context),
                                                child: CustomText(
                                                    text: bottomNavController
                                                        .selectedDateStr.value),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 20.sp,
                                            ),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () => bottomNavController
                                                    .selectTime(context),
                                                child: CustomText(
                                                    text: bottomNavController
                                                        .selectedTimeStr.value),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  kSizedBoxH30,
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CustomButton(
                                        width: 100.sp,
                                        text: 'save'.tr,
                                        bgColor: secondaryColor,
                                        outlineColor: secondaryColor,
                                        onTap: () {
                                          if (bottomNavController
                                              .amountTxtController
                                              .text
                                              .isNotEmpty) {
                                            bottomNavController
                                                .createExpenditure();
                                          } else {
                                            constants.showSnackBar(
                                                title: 'error'.tr,
                                                msg: 'amount_must_be_fill'.tr,
                                                textColor: Colors.red);
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

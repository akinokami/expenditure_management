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
import 'float_act_button_widget.dart';

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

  Widget buildBody(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const StatisticalHomeScreen();
      case 2:
        return const CalendarScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
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
        body: Obx(() => buildBody(bottomNavController.tabIndex.value)),
        floatingActionButton: Obx(
              () => bottomNavController.tabIndex.value == 0
              ? FloatActBtn(bottomNavController: bottomNavController)
              : Container(),
        ),
      ),
    );
  }
}

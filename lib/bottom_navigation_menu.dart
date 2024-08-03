import 'package:expenditure_management/custom_widgets/custom_card.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/custom_widgets/custom_text_button.dart';
import 'package:expenditure_management/custom_widgets/custom_text_field.dart';
import 'package:expenditure_management/views/calendar/calendar_screen.dart';
import 'package:expenditure_management/views/home/home_screen.dart';
import 'package:expenditure_management/views/profile/profile_screen.dart';
import 'package:expenditure_management/views/statistical/statistical_screen.dart';
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
            //backgroundColor: const Color(0xff1B8B00),
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
                label: 'Home',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.pie_chart,
                  size: 18.w,
                ),
                label: 'Statistical',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                  size: 18.w,
                ),
                label: 'Calendar',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 18.w,
                ),
                label: 'Profile',
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
            children: const [
              HomeScreen(),
              StatisticalScreen(),
              CalendarScreen(),
              ProfileScreen()
            ],
          )),
    ));
  }
}

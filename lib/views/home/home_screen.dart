import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // matchController.changeIndex(
                      //     index, appConfigController.mTabList[index].api ?? '');
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: CustomText(
                        fontSize: 10.sp,
                        text: 'Match ${index + 1}',
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}

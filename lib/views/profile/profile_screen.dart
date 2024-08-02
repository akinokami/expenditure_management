import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child:  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.mobile_screen_share_outlined),
                        title: CustomText(
                          text: 'Recommend app to friends',
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,),
                      ),
                      Divider(color: greyColor,),
                      ListTile(
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
                  child:  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete_outline,color: redColor),
                        title: CustomText(
                          text: 'Delete all data',
                          color: redColor,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: redColor),
                      ),
                      Divider(color: greyColor,),
                      ListTile(
                        leading: Icon(Icons.logout_outlined,color: redColor),
                        title: CustomText(
                          text: 'Sign out',
                          color: redColor,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: redColor),
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

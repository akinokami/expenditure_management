import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_card.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(controller: controller,fillColor: cardColor,)),
                  kSizedBoxW10,
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.filter_alt_outlined,color: secondaryColor),
                  )
                ],
              ),
              kSizedBoxH10,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,),
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Tue, 02-08-2024",color: primaryColor),
                    Row(
                      children: [
                        CustomText(text: "-9999999 VND",color: primaryColor,),
                        kSizedBoxW10,
                        Icon(Icons.arrow_forward_ios_rounded,color: primaryColor,size: 15.w,)
                      ],
                    )
                  ],
                ),
              ),
              kSizedBoxH10,
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            // matchController.changeIndex(
                            //     index, appConfigController.mTabList[index].api ?? '');
                          },
                          child: CustomCard(
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.category,size: 15.w),
                                        kSizedBoxW10,
                                        CustomText(
                                          fontSize: 10.sp,
                                          text: 'Income',
                                        ),
                                        kSizedBoxW10,
                                        Icon(Icons.wallet,size: 15.w,),
                                        kSizedBoxW10,
                                        CustomText(
                                          fontSize: 10.sp,
                                          text: 'Salary',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month,size: 15.w),
                                        kSizedBoxW10,
                                        CustomText(
                                          fontSize: 8.sp,
                                          text: '02-08-2024',
                                        ),
                                        kSizedBoxW10,
                                        Icon(Icons.watch_later_outlined,size: 15.w,),
                                        kSizedBoxW10,
                                        CustomText(
                                          fontSize: 8.sp,
                                          text: '12:19',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                CustomText(text: "+100000 VND"),
                              ],
                            ),
                          )

                          );
                    }),
              )
            ],
          ),
        ));
  }
}

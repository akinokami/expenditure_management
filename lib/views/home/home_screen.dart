import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/custom_widgets/custom_card.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/custom_widgets/custom_text_field.dart';
import 'package:expenditure_management/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    controller: homeController.searchTxtController,
                    fillColor: cardColor,
                  )),
                  kSizedBoxW10,
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        Icon(Icons.filter_alt_outlined, color: secondaryColor),
                  )
                ],
              ),
              kSizedBoxH10,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Tue, 02-08-2024", color: primaryColor),
                    Row(
                      children: [
                        CustomText(
                          text: "-9999999 VND",
                          color: primaryColor,
                        ),
                        kSizedBoxW10,
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: primaryColor,
                          size: 15.w,
                        )
                      ],
                    )
                  ],
                ),
              ),
              kSizedBoxH10,
              Obx(
                () => homeController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeController.expList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    //
                                  },
                                  child: CustomCard(
                                    widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.category,
                                                    size: 15.w),
                                                kSizedBoxW10,
                                                CustomText(
                                                  fontSize: 10.sp,
                                                  text: homeController
                                                          .expList[index]
                                                          .category
                                                          ?.name ??
                                                      '',
                                                ),
                                                kSizedBoxW10,
                                                Icon(
                                                  Icons.wallet,
                                                  size: 15.w,
                                                ),
                                                kSizedBoxW10,
                                                CustomText(
                                                  fontSize: 10.sp,
                                                  text: homeController
                                                          .expList[index]
                                                          .payment
                                                          ?.name ??
                                                      '',
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month,
                                                    size: 15.w),
                                                kSizedBoxW10,
                                                CustomText(
                                                  fontSize: 8.sp,
                                                  text: homeController
                                                          .expList[index]
                                                          .createdDate ??
                                                      '',
                                                ),
                                                kSizedBoxW10,
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  size: 15.w,
                                                ),
                                                kSizedBoxW10,
                                                CustomText(
                                                  fontSize: 8.sp,
                                                  text: homeController
                                                          .expList[index]
                                                          .createdDate ??
                                                      '',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        CustomText(
                                          text:
                                              "${homeController.expList[index].amount ?? ''}",
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
              )
            ],
          ),
        ));
  }
}

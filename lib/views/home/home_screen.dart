import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/controller/exp_update_controller.dart';
import 'package:expenditure_management/custom_widgets/custom_button.dart';
import 'package:expenditure_management/custom_widgets/custom_card.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../services/category_data.dart';
import '../../services/payment_method_data.dart';
import '../../utils/constants.dart';
import '../../utils/global.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final expUpdateController = Get.put(ExpUpdateController());

    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
              child: CustomTextField(
                hintText: 'search'.tr,
                onChanged: (value) {
                  homeController.searchExpenditures();
                },
                controller: homeController.searchTxtController,
                fillColor: cardColor,
              ),
            ),
            kSizedBoxH10,
            Obx(
              () => homeController.isLoading.value
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      ),
                    )
                  : homeController.expFilterList.isEmpty
                      ? Expanded(
                          child: Center(
                            child: CustomText(text: 'no_data_found'.tr),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeController.expFilterList.length,
                            itemBuilder: (context, index) {
                              int total = 0;
                              if ((homeController
                                          .expFilterList[index].expList ??
                                      [])
                                  .isNotEmpty) {
                                for (int i = 0;
                                    i <
                                        (homeController.expFilterList[index]
                                                    .expList ??
                                                [])
                                            .length;
                                    i++) {
                                  if (homeController.expFilterList[index]
                                          .expList?[i].expm?.type?.id ==
                                      1) {
                                    total -= (homeController
                                            .expFilterList[index]
                                            .expList?[i]
                                            .expm
                                            ?.amount ??
                                        0);
                                  } else {
                                    total += (homeController
                                            .expFilterList[index]
                                            .expList?[i]
                                            .expm
                                            ?.amount ??
                                        0);
                                  }
                                }
                              }

                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    width: double.infinity,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: homeController
                                                    .expFilterList[index]
                                                    .month ??
                                                '',
                                            color: primaryColor),
                                        Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  "${total.toString()} ${Global().currencySymbol}",
                                              color: primaryColor,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: homeController
                                          .expFilterList[index].expList?.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: ((context, index1) {
                                        return Slidable(
                                          key: ValueKey(index),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) {
                                                  expUpdateController
                                                      .deleteExpenditure(
                                                          docId: homeController
                                                                  .expFilterList[
                                                                      index]
                                                                  .expList?[
                                                                      index1]
                                                                  .docId ??
                                                              '');
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'delete'.tr,
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                              onTap: () {
                                                expUpdateController
                                                    .updateInitial(
                                                        expenditureModel:
                                                            homeController
                                                                .expFilterList[
                                                                    index]
                                                                .expList?[
                                                                    index1]
                                                                .expm);
                                                showModalBottomSheet(
                                                  backgroundColor: primaryColor,
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return FractionallySizedBox(
                                                      heightFactor: 0.9,
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            16.w),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Obx(
                                                                    () =>
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        expUpdateController
                                                                            .changeExpense();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                5.h,
                                                                            horizontal: 15.w),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: expUpdateController.isExpense.value
                                                                              ? secondaryColor
                                                                              : cardColor,
                                                                          borderRadius:
                                                                              const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            CustomText(
                                                                          text:
                                                                              'expense'.tr,
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Obx(() =>
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          expUpdateController
                                                                              .changeExpense();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 5.h,
                                                                              horizontal: 15.w),
                                                                          decoration: BoxDecoration(
                                                                              color: expUpdateController.isExpense.value ? cardColor : secondaryColor,
                                                                              borderRadius: const BorderRadius.only(
                                                                                topRight: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10),
                                                                              )),
                                                                          child:
                                                                              CustomText(
                                                                            text:
                                                                                'income'.tr,
                                                                            fontSize:
                                                                                14.sp,
                                                                            color:
                                                                                primaryColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 10.h),
                                                              SizedBox(
                                                                  height: 10.h),
                                                              TextField(
                                                                maxLength: 15,
                                                                controller:
                                                                    expUpdateController
                                                                        .amountTxtController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      cardColor,
                                                                  suffixText:
                                                                      "\u20AB",
                                                                  label:
                                                                      CustomText(
                                                                    text:
                                                                        'amount'
                                                                            .tr,
                                                                    color:
                                                                        greyColor,
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  disabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                ),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                              ),
                                                              SizedBox(
                                                                  height: 10.h),
                                                              TextField(
                                                                controller:
                                                                    expUpdateController
                                                                        .noteTxtController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      cardColor,
                                                                  label:
                                                                      CustomText(
                                                                    text: 'note'
                                                                        .tr,
                                                                    color:
                                                                        greyColor,
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  disabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        style: BorderStyle
                                                                            .none),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                ),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                              ),
                                                              kSizedBoxH10,
                                                              ExpansionTile(
                                                                  backgroundColor:
                                                                      cardColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10
                                                                              .r)),
                                                                  collapsedBackgroundColor:
                                                                      cardColor,
                                                                  collapsedShape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10
                                                                              .r)),
                                                                  title: CustomText(
                                                                      text: 'category'
                                                                          .tr),
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .w),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            300.h,
                                                                        child: GridView.builder(
                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                            itemCount: categoryList.length,
                                                                            shrinkWrap: true,
                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3, crossAxisCount: 3, crossAxisSpacing: 20.w, mainAxisSpacing: 10.h),
                                                                            itemBuilder: (context, index) {
                                                                              return Obx(
                                                                                () => GestureDetector(
                                                                                  onTap: () {
                                                                                    expUpdateController.selectedCategory.value = categoryList[index];
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(2.w),
                                                                                    decoration: BoxDecoration(
                                                                                      color: expUpdateController.selectedCategory.value.id == categoryList[index].id ? secondaryColor : greyColor,
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: CustomText(
                                                                                        text: Global.language == 'vi' ? categoryList[index].nameVn ?? "" : categoryList[index].name ?? "",
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
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100.w,
                                                                      padding: EdgeInsets
                                                                          .all(5
                                                                              .w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.r),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            CustomText(
                                                                          text: Global.language == 'vi'
                                                                              ? expUpdateController.selectedCategory.value.nameVn ?? ""
                                                                              : expUpdateController.selectedCategory.value.name ?? "",
                                                                          fontSize:
                                                                              10.sp,
                                                                          color:
                                                                              primaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              kSizedBoxH10,
                                                              ExpansionTile(
                                                                  backgroundColor:
                                                                      cardColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10
                                                                              .r)),
                                                                  collapsedBackgroundColor:
                                                                      cardColor,
                                                                  collapsedShape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10
                                                                              .r)),
                                                                  title: CustomText(
                                                                      text: 'payment_method'
                                                                          .tr),
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .w),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            100.h,
                                                                        child: GridView.builder(
                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                            itemCount: paymentList.length,
                                                                            shrinkWrap: true,
                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3, crossAxisCount: 3, crossAxisSpacing: 20.w, mainAxisSpacing: 10.h),
                                                                            itemBuilder: (context, index) {
                                                                              return Obx(
                                                                                () => GestureDetector(
                                                                                  onTap: () {
                                                                                    expUpdateController.selectedPayment.value = paymentList[index];
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(2.w),
                                                                                    decoration: BoxDecoration(
                                                                                      color: expUpdateController.selectedPayment.value.id == paymentList[index].id ? secondaryColor : greyColor,
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: CustomText(
                                                                                        text: Global.language == 'vi' ? paymentList[index].nameVn ?? "" : paymentList[index].name ?? "",
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
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100.w,
                                                                      padding: EdgeInsets
                                                                          .all(5
                                                                              .w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.r),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            CustomText(
                                                                          text: Global.language == 'vi'
                                                                              ? expUpdateController.selectedPayment.value.nameVn ?? ""
                                                                              : expUpdateController.selectedPayment.value.name ?? "",
                                                                          fontSize:
                                                                              10.sp,
                                                                          color:
                                                                              primaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              kSizedBoxH10,
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(10
                                                                            .w),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      cardColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <Widget>[
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          size:
                                                                              20.sp,
                                                                        ),
                                                                        Obx(
                                                                          () =>
                                                                              GestureDetector(
                                                                            onTap: () =>
                                                                                expUpdateController.selectDate(context),
                                                                            child:
                                                                                CustomText(text: expUpdateController.selectedDateStr.value),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .access_time,
                                                                          size:
                                                                              20.sp,
                                                                        ),
                                                                        Obx(
                                                                          () =>
                                                                              GestureDetector(
                                                                            onTap: () =>
                                                                                expUpdateController.selectTime(context),
                                                                            child:
                                                                                CustomText(text: expUpdateController.selectedTimeStr.value),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              kSizedBoxH30,
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    CustomButton(
                                                                        width: 100
                                                                            .sp,
                                                                        text: 'update'
                                                                            .tr,
                                                                        bgColor:
                                                                            secondaryColor,
                                                                        outlineColor:
                                                                            secondaryColor,
                                                                        onTap:
                                                                            () {
                                                                          if (expUpdateController
                                                                              .amountTxtController
                                                                              .text
                                                                              .isNotEmpty) {
                                                                            expUpdateController.updateExpenditure(docId: homeController.expFilterList[index].expList?[index1].docId ?? '');
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
                                              child: CustomCard(
                                                widget: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.category,
                                                                size: 15.w),
                                                            kSizedBoxW10,
                                                            CustomText(
                                                              fontSize: 10.sp,
                                                              text: Global.language ==
                                                                      'vi'
                                                                  ? (homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index]
                                                                          .expm
                                                                          ?.category
                                                                          ?.nameVn ??
                                                                      "")
                                                                  : homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index1]
                                                                          .expm
                                                                          ?.category
                                                                          ?.name ??
                                                                      "",
                                                            ),
                                                            kSizedBoxW10,
                                                            Icon(
                                                              Icons.wallet,
                                                              size: 15.w,
                                                            ),
                                                            kSizedBoxW10,
                                                            CustomText(
                                                              fontSize: 10.sp,
                                                              text: Global.language ==
                                                                      'vi'
                                                                  ? (homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index1]
                                                                          .expm
                                                                          ?.payment
                                                                          ?.nameVn ??
                                                                      "")
                                                                  : homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index1]
                                                                          .expm
                                                                          ?.payment
                                                                          ?.name ??
                                                                      "",
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                size: 15.w),
                                                            kSizedBoxW10,
                                                            CustomText(
                                                              fontSize: 8.sp,
                                                              text: (homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index1]
                                                                          .expm
                                                                          ?.updatedDate ??
                                                                      "")
                                                                  .split(' ')
                                                                  .elementAt(0),
                                                            ),
                                                            kSizedBoxW10,
                                                            Icon(
                                                              Icons
                                                                  .watch_later_outlined,
                                                              size: 15.w,
                                                            ),
                                                            kSizedBoxW10,
                                                            CustomText(
                                                              fontSize: 8.sp,
                                                              text: (homeController
                                                                          .expFilterList[
                                                                              index]
                                                                          .expList?[
                                                                              index1]
                                                                          .expm
                                                                          ?.updatedDate ??
                                                                      "")
                                                                  .split(' ')
                                                                  .elementAt(1),
                                                            ),
                                                          ],
                                                        ),
                                                        kSizedBoxH2,
                                                        Visibility(
                                                          visible: homeController
                                                                  .expFilterList[
                                                                      index]
                                                                  .expList?[
                                                                      index1]
                                                                  .expm
                                                                  ?.note !=
                                                              '',
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .note_alt_outlined,
                                                                  size: 15.w),
                                                              kSizedBoxW10,
                                                              CustomText(
                                                                text: homeController
                                                                        .expFilterList[
                                                                            index]
                                                                        .expList?[
                                                                            index1]
                                                                        .expm
                                                                        ?.note ??
                                                                    "",
                                                                fontSize: 10.sp,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    CustomText(
                                                      text: homeController
                                                                  .expFilterList[
                                                                      index]
                                                                  .expList?[
                                                                      index1]
                                                                  .expm
                                                                  ?.type
                                                                  ?.id ==
                                                              1
                                                          ? "- ${homeController.expFilterList[index].expList?[index1].expm?.amount ?? ''} ${Global().currencySymbol}"
                                                          : "+ ${homeController.expFilterList[index].expList?[index1].expm?.amount ?? ''} ${Global().currencySymbol}",
                                                      color: homeController
                                                                  .expFilterList[
                                                                      index]
                                                                  .expList?[
                                                                      index1]
                                                                  .expm
                                                                  ?.type
                                                                  ?.id ==
                                                              1
                                                          ? redColor
                                                          : secondaryColor,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
            ),
            kSizedBoxH10,
          ],
        ));
  }
}
//

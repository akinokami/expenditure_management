import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/constants/dimen_const.dart';
import 'package:expenditure_management/controller/exp_update_controller.dart';
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
import '../../utils/global.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final expUpdateController = Get.put(ExpUpdateController());

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
                    hintText: "Search",
                    onChanged: (va) {
                      homeController.searchList.clear();
                      //homeController.searchExpenditures();
                    },
                    controller: homeController.searchTxtController,
                    fillColor: cardColor,
                  )),
                  kSizedBoxW10,
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: secondaryColor,
                      size: 30.w,
                    ),
                  )
                ],
              ),
              kSizedBoxH10,
              Obx(
                () => homeController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeController.expGroupList.length,
                          itemBuilder: (context, index) {
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                          text: homeController
                                                  .expGroupList[index].month ??
                                              '',
                                          color: primaryColor),
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "1000 VND",
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homeController
                                      .expGroupList[index].expList?.length,
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
                                                              .expGroupList[
                                                                  index]
                                                              .expList?[index1]
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
                                            // expUpdateController.updateInitial(
                                            //     expenditureModel:
                                            //         homeController.searchList
                                            //                 .isNotEmpty
                                            //             ? homeController
                                            //                 .searchList[index]
                                            //             : homeController
                                            //                 .expList[index]);
                                            showModalBottomSheet(
                                              backgroundColor: primaryColor,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return FractionallySizedBox(
                                                  heightFactor: 0.9,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(16.w),
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
                                                                  onTap: () {
                                                                    expUpdateController
                                                                        .changeExpense();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            5.h,
                                                                        horizontal:
                                                                            15.w),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: expUpdateController
                                                                              .isExpense
                                                                              .value
                                                                          ? secondaryColor
                                                                          : cardColor,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        CustomText(
                                                                      text:
                                                                          "Expense",
                                                                      fontSize:
                                                                          16.sp,
                                                                      color:
                                                                          primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Obx(() =>
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      expUpdateController
                                                                          .changeExpense();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 5
                                                                              .h,
                                                                          horizontal:
                                                                              15.w),
                                                                      decoration: BoxDecoration(
                                                                          color: expUpdateController.isExpense.value ? cardColor : secondaryColor,
                                                                          borderRadius: const BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                          )),
                                                                      child:
                                                                          CustomText(
                                                                        text:
                                                                            "Income",
                                                                        fontSize:
                                                                            16.sp,
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
                                                              label: CustomText(
                                                                text: "Amount",
                                                                fontSize: 16.sp,
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                              label: CustomText(
                                                                text: "Note",
                                                                fontSize: 16.sp,
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                    BorderRadius
                                                                        .circular(
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
                                                                      BorderRadius
                                                                          .circular(10
                                                                              .r)),
                                                              collapsedBackgroundColor:
                                                                  cardColor,
                                                              collapsedShape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(10
                                                                              .r)),
                                                              title: Text(
                                                                  "Category"),
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .w),
                                                                  child:
                                                                      SizedBox(
                                                                    height:
                                                                        260.h,
                                                                    child: GridView.builder(
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        itemCount: categoryList.length,
                                                                        shrinkWrap: true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3, crossAxisCount: 3, crossAxisSpacing: 20.w, mainAxisSpacing: 10.h),
                                                                        itemBuilder: (context, index) {
                                                                          return Obx(
                                                                            () =>
                                                                                GestureDetector(
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
                                                                                    text: categoryList[index].name ?? "",
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
                                                                  width: 100.w,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(5
                                                                              .w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        secondaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        CustomText(
                                                                      text: expUpdateController
                                                                              .selectedCategory
                                                                              .value
                                                                              .name ??
                                                                          "",
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
                                                                      BorderRadius
                                                                          .circular(10
                                                                              .r)),
                                                              collapsedBackgroundColor:
                                                                  cardColor,
                                                              collapsedShape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(10
                                                                              .r)),
                                                              title: Text(
                                                                  "Payment Method"),
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .w),
                                                                  child:
                                                                      SizedBox(
                                                                    height:
                                                                        100.h,
                                                                    child: GridView.builder(
                                                                        itemCount: paymentList.length,
                                                                        shrinkWrap: true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3, crossAxisCount: 3, crossAxisSpacing: 20.w, mainAxisSpacing: 10.h),
                                                                        itemBuilder: (context, index) {
                                                                          return Obx(
                                                                            () =>
                                                                                GestureDetector(
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
                                                                                    text: paymentList[index].name ?? "",
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
                                                                  width: 100.w,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(5
                                                                              .w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        secondaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        CustomText(
                                                                      text: expUpdateController
                                                                              .selectedPayment
                                                                              .value
                                                                              .name ??
                                                                          "",
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
                                                                EdgeInsets.all(
                                                                    10.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: cardColor,
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
                                                                    Icon(Icons
                                                                        .calendar_month),
                                                                    Obx(
                                                                      () =>
                                                                          GestureDetector(
                                                                        onTap: () =>
                                                                            expUpdateController.selectDate(context),
                                                                        child: Text(expUpdateController
                                                                            .selectedDateStr
                                                                            .value),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .access_time),
                                                                    Obx(
                                                                      () =>
                                                                          GestureDetector(
                                                                        onTap: () =>
                                                                            expUpdateController.selectTime(context),
                                                                        child: Text(expUpdateController
                                                                            .selectedTimeStr
                                                                            .value),
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
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                expUpdateController.updateExpenditure(
                                                                    docId: homeController
                                                                            .expGroupList[index]
                                                                            .expList?[index1]
                                                                            .docId ??
                                                                        '');
                                                              },
                                                              child: CustomText(
                                                                  text: 'update'
                                                                      .tr),
                                                            ),
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
                                                                  .searchList
                                                                  .isNotEmpty
                                                              ? homeController
                                                                      .searchList[
                                                                          index]
                                                                      .category
                                                                      ?.name ??
                                                                  ''
                                                              : homeController
                                                                      .expGroupList[
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
                                                          text: homeController
                                                                  .searchList
                                                                  .isNotEmpty
                                                              ? homeController
                                                                      .searchList[
                                                                          index]
                                                                      .payment
                                                                      ?.name ??
                                                                  ''
                                                              : homeController
                                                                      .expGroupList[
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
                                                                      .searchList
                                                                      .isNotEmpty
                                                                  ? homeController
                                                                          .searchList[
                                                                              index]
                                                                          .updatedDate ??
                                                                      ''
                                                                  : homeController
                                                                          .expGroupList[
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
                                                                      .searchList
                                                                      .isNotEmpty
                                                                  ? homeController
                                                                          .searchList[
                                                                              index]
                                                                          .updatedDate ??
                                                                      ''
                                                                  : homeController
                                                                          .expGroupList[
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
                                                    )
                                                  ],
                                                ),
                                                CustomText(
                                                  text: homeController
                                                          .searchList.isNotEmpty
                                                      ? "${homeController.searchList[index].amount ?? ''}"
                                                      : "${homeController.expGroupList[index].expList?[index1].expm?.amount ?? ''}",
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                                  }),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
              kSizedBoxH10,
            ],
          ),
        ));
  }
}
//

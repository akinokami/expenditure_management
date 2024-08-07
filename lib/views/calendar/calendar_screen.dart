import 'dart:async';
import 'dart:collection';

import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/controller/exp_update_controller.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/models/expenditure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/dimen_const.dart';
import '../../controller/calendar_controller.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_card.dart';
import '../../services/category_data.dart';
import '../../services/firestore_service.dart';
import '../../services/payment_method_data.dart';
import '../../utils/constants.dart';
import '../../utils/global.dart';
import '../../utils/utils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final calendarController = Get.put(CalendarController());
  final expUpdateController = Get.put(ExpUpdateController());
  // List<Expenditure> expList = [];

  // final firestoreService = FireStoreService();
  // bool isLoading = false;

  ///
  final ValueNotifier<List<Expenditure>> selectedExpenditures =
      ValueNotifier([]);

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedExpenditures.dispose();
    super.dispose();
  }

  List<Expenditure> getExpenditureForDay(DateTime day) {
    final kExpenditures = LinkedHashMap<DateTime, List<Expenditure>>(
      equals: isSameDay,
      hashCode: getHashCode,
      // ignore: prefer_for_elements_to_map_fromiterable
    )..addAll(Map.fromIterable(calendarController.expList,
        key: (item) => day,
        value: (item) {
          List<Expenditure> eList = [];

          for (var exp in calendarController.expList) {
            if (DateFormat('yyyy-MM-dd').format(day).toString() ==
                DateFormat('yyyy-MM-dd')
                    .format(exp.calDate ?? DateTime.now())
                    .toString()) {
              eList.add(exp);
            }
          }
          return eList;
        }));
    return kExpenditures[day] ?? [];
  }

  List<Expenditure> getExpenditureForDays(Set<DateTime> days) {
    return [
      for (final d in days) ...getExpenditureForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });

    selectedExpenditures.value = getExpenditureForDays(_selectedDays);
    calendarController.calculateTotal(selectedExpenditures.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'expenditure_calendar'.tr,
          fontSize: 14.sp,
        ),
      ),
      body: ListView(
        children: [
          TableCalendar<Expenditure>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: getExpenditureForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              // Use values from Set to mark multiple days as selected
              return _selectedDays.contains(day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          kSizedBoxH10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'expense'.tr,
                        fontSize: 12.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: calendarController.totalExpense.value == 0
                            ? "${calendarController.totalExpense} ${Global().currencySymbol}"
                            : "- ${calendarController.totalExpense} ${Global().currencySymbol}",
                        fontSize: 12.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    child: Column(
                      children: [
                        CustomText(
                          text: 'income'.tr,
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        CustomText(
                          text: calendarController.totalIncome.value == 0
                              ? "${calendarController.totalIncome} ${Global().currencySymbol}"
                              : "+ ${calendarController.totalIncome} ${Global().currencySymbol}",
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Obx(
            () => calendarController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ValueListenableBuilder<List<Expenditure>>(
                    valueListenable: selectedExpenditures,
                    builder: (context, value, _) {
                      return value.isEmpty
                          ? Center(
                              child: CustomText(text: 'no_data_found'.tr),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            expUpdateController
                                                .deleteExpenditure(
                                                    docId: value[index].docId ??
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
                                          expUpdateController.updateInitial(
                                              expenditureModel:
                                                  value[index].expm);
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
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      CustomText(
                                                                    text:
                                                                        'expense'
                                                                            .tr,
                                                                    fontSize:
                                                                        14.sp,
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
                                                                        vertical:
                                                                            5.h,
                                                                        horizontal:
                                                                            15.w),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color: expUpdateController.isExpense.value
                                                                                ? cardColor
                                                                                : secondaryColor,
                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topRight: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10),
                                                                            )),
                                                                    child:
                                                                        CustomText(
                                                                      text: 'income'
                                                                          .tr,
                                                                      fontSize:
                                                                          14.sp,
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
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        SizedBox(height: 10.h),
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
                                                            label: CustomText(
                                                              text: 'amount'.tr,
                                                              color: greyColor,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                        SizedBox(height: 10.h),
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
                                                              text: 'note'.tr,
                                                              color: greyColor,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                                  style:
                                                                      BorderStyle
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
                                                            title: CustomText(
                                                                text: 'category'
                                                                    .tr),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8
                                                                            .w),
                                                                child: SizedBox(
                                                                  height: 300.h,
                                                                  child: GridView
                                                                      .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          itemCount: categoryList
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                              childAspectRatio: 3,
                                                                              crossAxisCount: 3,
                                                                              crossAxisSpacing: 20.w,
                                                                              mainAxisSpacing: 10.h),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      CustomText(
                                                                    text: Global.language ==
                                                                            'vi'
                                                                        ? expUpdateController.selectedCategory.value.nameVn ??
                                                                            ""
                                                                        : expUpdateController.selectedCategory.value.name ??
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
                                                            title: CustomText(
                                                                text:
                                                                    'payment_method'
                                                                        .tr),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8
                                                                            .w),
                                                                child: SizedBox(
                                                                  height: 100.h,
                                                                  child: GridView
                                                                      .builder(
                                                                          itemCount: paymentList
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                              childAspectRatio: 3,
                                                                              crossAxisCount: 3,
                                                                              crossAxisSpacing: 20.w,
                                                                              mainAxisSpacing: 10.h),
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      CustomText(
                                                                    text: Global.language ==
                                                                            'vi'
                                                                        ? expUpdateController.selectedPayment.value.nameVn ??
                                                                            ""
                                                                        : expUpdateController.selectedPayment.value.name ??
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
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_month,
                                                                    size: 20.sp,
                                                                  ),
                                                                  Obx(
                                                                    () =>
                                                                        GestureDetector(
                                                                      onTap: () =>
                                                                          expUpdateController
                                                                              .selectDate(context),
                                                                      child: CustomText(
                                                                          text: expUpdateController
                                                                              .selectedDateStr
                                                                              .value),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .access_time,
                                                                    size: 20.sp,
                                                                  ),
                                                                  Obx(
                                                                    () =>
                                                                        GestureDetector(
                                                                      onTap: () =>
                                                                          expUpdateController
                                                                              .selectTime(context),
                                                                      child: CustomText(
                                                                          text: expUpdateController
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
                                                          child: CustomButton(
                                                              width: 100.sp,
                                                              text: 'update'.tr,
                                                              bgColor:
                                                                  secondaryColor,
                                                              outlineColor:
                                                                  secondaryColor,
                                                              onTap: () {
                                                                if (expUpdateController
                                                                    .amountTxtController
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  expUpdateController
                                                                      .updateExpenditure(
                                                                          docId:
                                                                              value[index].docId ?? '');
                                                                } else {
                                                                  constants.showSnackBar(
                                                                      title:
                                                                          'error'
                                                                              .tr,
                                                                      msg: 'amount_must_be_fill'
                                                                          .tr,
                                                                      textColor:
                                                                          Colors
                                                                              .red);
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
                                                        text: Global.language ==
                                                                'vi'
                                                            ? value[index]
                                                                    .expm
                                                                    ?.category
                                                                    ?.nameVn ??
                                                                ""
                                                            : value[index]
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
                                                            ? (value[index]
                                                                    .expm
                                                                    ?.payment
                                                                    ?.nameVn ??
                                                                "")
                                                            : value[index]
                                                                    .expm
                                                                    ?.payment
                                                                    ?.name ??
                                                                "",
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
                                                        text: (value[index]
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
                                                        text: (value[index]
                                                                    .expm
                                                                    ?.updatedDate ??
                                                                "")
                                                            .split(' ')
                                                            .elementAt(1),
                                                      ),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: value[index]
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
                                                          text: value[index]
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
                                                text: value[index]
                                                            .expm
                                                            ?.type
                                                            ?.id ==
                                                        1
                                                    ? "- ${value[index].expm?.amount ?? ''} ${Global().currencySymbol}"
                                                    : "+ ${value[index].expm?.amount ?? ''} ${Global().currencySymbol}",
                                                color: value[index]
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
                                },
                              ),
                            );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

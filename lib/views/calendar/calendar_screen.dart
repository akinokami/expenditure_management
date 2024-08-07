import 'package:expenditure_management/controller/calendar_controller.dart';
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../controller/home_controller.dart';
import '../../custom_widgets/custom_card.dart';

class ExpenditureCalendar extends StatefulWidget {
  final String userId;

  ExpenditureCalendar({required this.userId});

  @override
  _ExpenditureCalendarState createState() => _ExpenditureCalendarState();
}

class _ExpenditureCalendarState extends State<ExpenditureCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<ExpenditureModel>> _expenditures = {};

  @override
  void initState() {
    super.initState();
    // _loadExpenditures();
  }

  // void _loadExpenditures() async {
  //   // Simulating fetching data from Firestore
  //  // List<ExpenditureModel> data = await fetchExpenditures(widget.userId);
  //   Map<DateTime, List<ExpenditureModel>> groupedExpenditures =
  //       _groupByDate(data);
  //   setState(() {
  //     _expenditures = groupedExpenditures;
  //   });
  //   print("zzzzzzzz ${data.length}");
  // }

  Map<DateTime, List<ExpenditureModel>> _groupByDate(
      List<ExpenditureModel> expenditures) {
    Map<DateTime, List<ExpenditureModel>> grouped = {};

    for (var exp in expenditures) {
      DateTime date = DateTime.parse(exp.updatedDate ?? "");
      DateTime formattedDate = DateTime(
          date.year, date.month, date.day); // Only keep year, month, day
      print("FormateeDate $formattedDate ");
      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(exp);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final calendarComponent = Get.put(CalendarController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'expenditure_calendar'.tr,
          fontSize: 14.sp,
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
                print("Select Day $_selectedDay");
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _expenditures[day] ?? [];
            },
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    calendarComponent.changeExpense();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: calendarComponent.isExpense.value
                          ? secondaryColor
                          : cardColor,
                      borderRadius: const BorderRadius.only(
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
                      calendarComponent.changeExpense();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: calendarComponent.isExpense.value
                              ? cardColor
                              : secondaryColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
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
          _buildExpenditureList(),
        ],
      ),
    );
  }

  Widget _buildExpenditureList() {
    List<ExpenditureModel> selectedExpenditures =
        _expenditures[_selectedDay] ?? [];

    if ((selectedExpenditures.isNotEmpty)) {
      print("${selectedExpenditures[0].updatedDate} xxxxxxxx");
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: selectedExpenditures.length,
            itemBuilder: (context, index) {
              var exp = selectedExpenditures[index];
              return GestureDetector(
                  onTap: () {
                    //
                  },
                  child: CustomCard(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.category, size: 15.w),
                                kSizedBoxW10,
                                CustomText(
                                  fontSize: 10.sp,
                                  text: exp.category?.name ?? '',
                                ),
                                kSizedBoxW10,
                                Icon(
                                  Icons.wallet,
                                  size: 15.w,
                                ),
                                kSizedBoxW10,
                                CustomText(
                                  fontSize: 10.sp,
                                  text: exp.payment?.name ?? '',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month, size: 15.w),
                                kSizedBoxW10,
                                CustomText(
                                  fontSize: 8.sp,
                                  text: exp.createdDate ?? '',
                                ),
                                kSizedBoxW10,
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: 15.w,
                                ),
                                kSizedBoxW10,
                                CustomText(
                                  fontSize: 8.sp,
                                  text: exp.createdDate ?? '',
                                ),
                              ],
                            )
                          ],
                        ),
                        CustomText(
                          text: "${exp.amount ?? ''}",
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      );
    } else {
      return CustomText(text: "NoData");
    }
  }
}

// Future<List<ExpenditureModel>> fetchExpenditures(String userId) async {

//   await Future.delayed(Duration(seconds: 1)); 
//   return Get.find<HomeController>().expList;

// }

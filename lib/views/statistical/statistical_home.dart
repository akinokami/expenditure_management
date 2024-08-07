import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../controller/home_controller.dart';
import '../../custom_widgets/custom_card.dart';
import '../../custom_widgets/custom_text.dart';

class StatisticalHomeScreen extends StatefulWidget {
  const StatisticalHomeScreen({super.key});

  @override
  State<StatisticalHomeScreen> createState() => _StatisticalHomeScreenState();
}

class _StatisticalHomeScreenState extends State<StatisticalHomeScreen> {
  bool isExpense = true;
  var expL = Get.find<HomeController>().pieExpenseList;
  Set<int> displayedCategoryIds = {};
  void changeType() {
    setState(() {
      isExpense = !isExpense;
      displayedCategoryIds.clear();
      if (isExpense) {
        expL = Get.find<HomeController>().pieExpenseList;
      } else {
        expL = Get.find<HomeController>().pieIncomeList;
      }
    });
  }

  Color getCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.purple;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      case 6:
        return Colors.pink;
      case 7:
        return Colors.teal;
      case 8:
        return Colors.cyan;
      case 9:
        return Colors.indigo;
      case 10:
        return Colors.lime;
      case 11:
        return Colors.brown;
      case 12:
        return Colors.deepOrange;
      case 13:
        return Colors.lightGreen;
      case 14:
        return Colors.lightBlue;
      case 15:
        return Colors.amber;
      case 16:
        return Colors.deepPurple;
      case 17:
        return Colors.blueGrey;
      case 18:
        return Colors.lightGreenAccent;
      case 19:
        return secondaryColor;
      case 20:
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    displayedCategoryIds.clear();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    changeType();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: isExpense ? secondaryColor : cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                    ),
                    child: CustomText(
                      text: "Expense",
                      fontSize: 16.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeType();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        color: isExpense ? cardColor : secondaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        )),
                    child: CustomText(
                      text: "Income",
                      fontSize: 16.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 1.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: PieChart(
                        PieChartData(
                          // pieTouchData: PieTouchData(
                          //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          //     setState(() {
                          //       if (!event.isInterestedForInteractions ||
                          //           pieTouchResponse == null ||
                          //           pieTouchResponse.touchedSection == null) {
                          //         touchedIndex = -1;
                          //         return;
                          //       }
                          //       touchedIndex = pieTouchResponse
                          //           .touchedSection!.touchedSectionIndex;
                          //     });
                          //   },
                          // ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 4,
                          sections: showingSections(isExpense),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                      width: 120.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: expL.length,
                        itemBuilder: (context, i) {
                          var category = expL[i].category;
                          if (category == null ||
                              displayedCategoryIds.contains(category.id)) {
                            return Container(); // Skip rendering if category is null or already displayed
                          }
                          displayedCategoryIds.add(category.id ?? 0);

                          var sectionColor = getCategoryColor(category.id ?? 0);
                          var categoryName = category.name;

                          // Calculate the total amount and the percentage for each category
                          final totalAmount = expL.fold(
                              0.0,
                              (sum, item) =>
                                  sum + (item.amount?.toDouble() ?? 0));
                          final categoryAmount = expL
                              .where((item) => item.category?.id == category.id)
                              .fold(
                                  0.0,
                                  (sum, item) =>
                                      sum + (item.amount?.toDouble() ?? 0));
                          final percentage =
                              (categoryAmount / totalAmount) * 100;

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: sectionColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                    width: 2
                                        .w), // Add some spacing between circle and text
                                CustomText(
                                    text:
                                        '${categoryName ?? ""} (${percentage.toStringAsFixed(1)}%)',
                                    fontSize: 8.sp),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: expL.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
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
                                    text: expL[index].category?.name ?? "",
                                  ),
                                  kSizedBoxW10,
                                  Icon(
                                    Icons.wallet,
                                    size: 15.w,
                                  ),
                                  kSizedBoxW10,
                                  CustomText(
                                    fontSize: 10.sp,
                                    text: expL[index].payment?.name ?? "",
                                  ),
                                ],
                              ),
                              kSizedBoxH2,
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: 15.w),
                                  kSizedBoxW10,
                                  CustomText(
                                    fontSize: 8.sp,
                                    text: expL[index].updatedDate ??
                                        "".split(' ').elementAt(0),
                                  ),
                                  kSizedBoxW10,
                                  Icon(
                                    Icons.watch_later_outlined,
                                    size: 15.w,
                                  ),
                                  kSizedBoxW10,
                                  CustomText(
                                    fontSize: 8.sp,
                                    text: expL[index].updatedDate ??
                                        "".split(' ').elementAt(1),
                                  ),
                                ],
                              ),
                              kSizedBoxH2,
                              if((expL[index].note!=""))  Row(
                                children: [
                                  Icon(Icons.note_alt_outlined, size: 15.w),kSizedBoxW10,
                                  CustomText(text: expL[index].note??"",fontSize: 8.sp,),
                                ],
                              )
                            ],
                          ),
                          CustomText(
                            text: isExpense
                                ? "- ${expL[index].amount ?? ''} \u20AB"
                                : "+ ${expL[index].amount ?? ''} \u20AB",
                            color: isExpense ? redColor : secondaryColor,
                          ),
                        ],
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(bool isExpense) {
    var exp;
    if (isExpense) {
      exp = Get.find<HomeController>().pieExpenseList;
    } else {
      exp = Get.find<HomeController>().pieIncomeList;
    }

    // Calculate the total amount
    final totalAmount =
        exp.fold(0.0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

    // Group expenses by category and sum the amounts for each category
    Map<int, double> categoryAmounts = {};
    for (var item in exp) {
      if (item.category != null && item.amount != null) {
        categoryAmounts.update(
          item.category!.id ?? 0,
          (existingValue) => existingValue + item.amount!.toDouble(),
          ifAbsent: () => item.amount!.toDouble(),
        );
      }
    }

    // Generate the sections for the pie chart
    return categoryAmounts.entries.map((entry) {
      int categoryId = entry.key;
      double value = entry.value;
      double percentage = (value / totalAmount) * 100;
      String title = '${percentage.toStringAsFixed(1)}%';

      // Determine the color for the section
      var sectionColor = getCategoryColor(categoryId);

      return PieChartSectionData(
        color: sectionColor,
        value: value,
        title: title,
        radius: 100.0,
        titleStyle: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    }).toList();
  }
}

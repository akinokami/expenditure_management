import 'package:expenditure_management/views/statistical/pie_chart.dart';
import 'package:expenditure_management/views/statistical/statistical_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controller/home_controller.dart';
import '../../custom_widgets/custom_text.dart';

class StatisticalHomeScreen extends StatefulWidget {
  const StatisticalHomeScreen({super.key});

  @override
  State<StatisticalHomeScreen> createState() => _StatisticalHomeScreenState();
}

class _StatisticalHomeScreenState extends State<StatisticalHomeScreen> {
  bool isExpense=false;
  var expL=Get.find<HomeController>().pieExpenseList;
  void changeType(){
    setState(() {
      isExpense=!isExpense;
      if(isExpense){
        expL=Get.find<HomeController>().pieExpenseList;
      }else{
        expL=Get.find<HomeController>().pieIncomeList;
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio:1.3,
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
                      sections:isExpense?showingExpenseSections(): showingIncomeSections(),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height*.3,
                    width: MediaQuery.of(context).size.width*.3,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: expL.length,
                        itemBuilder: (context,i){

                          var sectionColor;
                          if (expL[i].category?.id == 0) {
                            sectionColor = Colors.yellow;
                          } else if (expL[i].category?.id == 1) {
                            sectionColor = Colors.purple;
                          } else if (expL[i].category?.id == 2) {
                            sectionColor = Colors.green;
                          } else if (expL[i].category?.id == 3) {
                            sectionColor = Colors.blue;
                          } else if (expL[i].category?.id == 4) {
                            sectionColor = Colors.orange;
                          } else if (expL[i].category?.id == 5) {
                            sectionColor = Colors.red;
                          } else if (expL[i].category?.id == 6) {
                            sectionColor = Colors.pink;
                          } else if (expL[i].category?.id == 7) {
                            sectionColor = Colors.teal;
                          } else if (expL[i].category?.id == 8) {
                            sectionColor = Colors.cyan;
                          } else if (expL[i].category?.id == 9) {
                            sectionColor = Colors.indigo;
                          } else if (expL[i].category?.id == 10) {
                            sectionColor = Colors.lime;
                          } else if (expL[i].category?.id == 11) {
                            sectionColor = Colors.brown;
                          } else if (expL[i].category?.id == 12) {
                            sectionColor = Colors.deepOrange;
                          } else if (expL[i].category?.id == 13) {
                            sectionColor = Colors.lightGreen;
                          } else if (expL[i].category?.id == 14) {
                            sectionColor = Colors.lightBlue;
                          } else if (expL[i].category?.id == 15) {
                            sectionColor = Colors.amber;
                          } else if (expL[i].category?.id == 16) {
                            sectionColor = Colors.deepPurple;
                          } else if (expL[i].category?.id == 17) {
                            sectionColor = Colors.blueGrey;
                          } else if (expL[i].category?.id == 18) {
                            sectionColor = Colors.lightGreenAccent;
                          } else if (expL[i].category?.id == 19) {
                            sectionColor = Colors.redAccent;
                          } else if (expL[i].category?.id == 20) {
                            sectionColor = Colors.pinkAccent;
                          } else {
                            // Fallback for unexpected index
                            sectionColor = Colors.grey;

                          }
                          // String? currentName = expL[i].category?.name;
                          // bool showName = i == 0 || expL[i - 1].category?.name != currentName;
                          return Row(
                            children: [  Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: sectionColor,
                                  shape: BoxShape.circle
                              ),
                            ),
                              CustomText(text: expL[i].category?.name??"")
                            ],
                          );
                        }),
                  )
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
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
                  color: isExpense
                      ? secondaryColor
                      : cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
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
                    color: isExpense
                        ? cardColor
                        : secondaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
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
        )
      ],
    );
  }

  // List<PieChartSectionData> showingExpenseSections() {
  //   final exp = Get.find<HomeController>().pieExpenseList;
  //
  //   // Calculate the total amount
  //   final totalAmount = exp.fold(0.0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));
  //
  //   return List.generate(exp.length, (i) {
  //     // final isTouched = i == touchedIndex;
  //     final fontSize = 10.0;
  //     final radius =  100.0;
  //     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
  //
  //     Color sectionColor;
  //     double value = exp[i].amount?.toDouble() ?? 0;
  //     double percentage = (value / totalAmount) * 100;
  //     String title = '${percentage.toStringAsFixed(1)}%';
  //
  //     if (exp[i].category?.id == 0) {
  //       sectionColor = Colors.yellow;
  //     } else if (exp[i].category?.id == 1) {
  //       sectionColor = Colors.purple;
  //     } else if (exp[i].category?.id == 2) {
  //       sectionColor = Colors.green;
  //     } else if (exp[i].category?.id == 3) {
  //       sectionColor = Colors.blue;
  //     } else if (exp[i].category?.id == 4) {
  //       sectionColor = Colors.orange;
  //     } else if (exp[i].category?.id == 5) {
  //       sectionColor = Colors.red;
  //     } else if (exp[i].category?.id == 6) {
  //       sectionColor = Colors.pink;
  //     } else if (exp[i].category?.id == 7) {
  //       sectionColor = Colors.teal;
  //     } else if (exp[i].category?.id == 8) {
  //       sectionColor = Colors.cyan;
  //     } else if (exp[i].category?.id == 9) {
  //       sectionColor = Colors.indigo;
  //     } else if (exp[i].category?.id == 10) {
  //       sectionColor = Colors.lime;
  //     } else if (exp[i].category?.id == 11) {
  //       sectionColor = Colors.brown;
  //     } else if (exp[i].category?.id == 12) {
  //       sectionColor = Colors.deepOrange;
  //     } else if (exp[i].category?.id == 13) {
  //       sectionColor = Colors.lightGreen;
  //     } else if (exp[i].category?.id == 14) {
  //       sectionColor = Colors.lightBlue;
  //     } else if (exp[i].category?.id == 15) {
  //       sectionColor = Colors.amber;
  //     } else if (exp[i].category?.id == 16) {
  //       sectionColor = Colors.deepPurple;
  //     } else if (exp[i].category?.id == 17) {
  //       sectionColor = Colors.blueGrey;
  //     } else if (exp[i].category?.id == 18) {
  //       sectionColor = Colors.lightGreenAccent;
  //     } else if (exp[i].category?.id == 19) {
  //       sectionColor = Colors.redAccent;
  //     } else if (exp[i].category?.id == 20) {
  //       sectionColor = Colors.pinkAccent;
  //     } else {
  //       // Fallback for unexpected index
  //       sectionColor = Colors.grey;
  //       value = 0;
  //       title = 'N/A';
  //     }
  //
  //     return PieChartSectionData(
  //       color: sectionColor,
  //       value: value,
  //       title: title,
  //       radius: radius,
  //       titleStyle: TextStyle(
  //         fontSize: fontSize,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //         shadows: shadows,
  //       ),
  //     );
  //   });
  //
  // }
  List<PieChartSectionData> showingExpenseSections() {
    final exp = Get.find<HomeController>().pieExpenseList;

    // Calculate the total amount
    final totalAmount = exp.fold(0.0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

    // Group expenses by category and sum the amounts for each category
    Map<int, double> categoryAmounts = {};
    for (var item in exp) {
      if (item.category != null && item.amount != null) {
        categoryAmounts.update(
          item.category!.id??0,
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
      Color sectionColor;
      switch (categoryId) {
        case 0:
          sectionColor = Colors.yellow;
          break;
        case 1:
          sectionColor = Colors.purple;
          break;
        case 2:
          sectionColor = Colors.green;
          break;
        case 3:
          sectionColor = Colors.blue;
          break;
        case 4:
          sectionColor = Colors.orange;
          break;
        case 5:
          sectionColor = Colors.red;
          break;
        case 6:
          sectionColor = Colors.pink;
          break;
        case 7:
          sectionColor = Colors.teal;
          break;
        case 8:
          sectionColor = Colors.cyan;
          break;
        case 9:
          sectionColor = Colors.indigo;
          break;
        case 10:
          sectionColor = Colors.lime;
          break;
        case 11:
          sectionColor = Colors.brown;
          break;
        case 12:
          sectionColor = Colors.deepOrange;
          break;
        case 13:
          sectionColor = Colors.lightGreen;
          break;
        case 14:
          sectionColor = Colors.lightBlue;
          break;
        case 15:
          sectionColor = Colors.amber;
          break;
        case 16:
          sectionColor = Colors.deepPurple;
          break;
        case 17:
          sectionColor = Colors.blueGrey;
          break;
        case 18:
          sectionColor = Colors.lightGreenAccent;
          break;
        case 19:
          sectionColor = Colors.redAccent;
          break;
        case 20:
          sectionColor = Colors.pinkAccent;
          break;
        default:
          sectionColor = Colors.grey;
          title = 'N/A';
          value = 0;
      }

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

  List<PieChartSectionData> showingIncomeSections() {
    final exp = Get.find<HomeController>().pieIncomeList;

    // Calculate the total amount
    final totalAmount = exp.fold(0.0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

    return List.generate(exp.length, (i) {

      final fontSize =
      10.0;
      final radius =  100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      Color sectionColor;
      double value = exp[i].amount?.toDouble() ?? 0;
      double percentage = (value / totalAmount) * 100;
      String title = '${percentage.toStringAsFixed(1)}%';

      if (exp[i].category?.id == 0) {
        sectionColor = Colors.yellow;
      } else if (exp[i].category?.id == 1) {
        sectionColor = Colors.purple;
      } else if (exp[i].category?.id == 2) {
        sectionColor = Colors.green;
      } else if (exp[i].category?.id == 3) {
        sectionColor = Colors.blue;
      } else if (exp[i].category?.id == 4) {
        sectionColor = Colors.orange;
      } else if (exp[i].category?.id == 5) {
        sectionColor = Colors.red;
      } else if (exp[i].category?.id == 6) {
        sectionColor = Colors.pink;
      } else if (exp[i].category?.id == 7) {
        sectionColor = Colors.teal;
      } else if (exp[i].category?.id == 8) {
        sectionColor = Colors.cyan;
      } else if (exp[i].category?.id == 9) {
        sectionColor = Colors.indigo;
      } else if (exp[i].category?.id == 10) {
        sectionColor = Colors.lime;
      } else if (exp[i].category?.id == 11) {
        sectionColor = Colors.brown;
      } else if (exp[i].category?.id == 12) {
        sectionColor = Colors.deepOrange;
      } else if (exp[i].category?.id == 13) {
        sectionColor = Colors.lightGreen;
      } else if (exp[i].category?.id == 14) {
        sectionColor = Colors.lightBlue;
      } else if (exp[i].category?.id == 15) {
        sectionColor = Colors.amber;
      } else if (exp[i].category?.id == 16) {
        sectionColor = Colors.deepPurple;
      } else if (exp[i].category?.id == 17) {
        sectionColor = Colors.blueGrey;
      } else if (exp[i].category?.id == 18) {
        sectionColor = Colors.lightGreenAccent;
      } else if (exp[i].category?.id == 19) {
        sectionColor = Colors.redAccent;
      } else if (exp[i].category?.id == 20) {
        sectionColor = Colors.pinkAccent;
      } else {
        // Fallback for unexpected index
        sectionColor = Colors.grey;
        value = 0;
        title = 'N/A';
      }

      return PieChartSectionData(
        color: sectionColor,
        value: value,
        title: title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });

  }
}

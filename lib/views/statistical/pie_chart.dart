//
import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:expenditure_management/services/category_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final expL = Get.find<HomeController>().expList;
    return AspectRatio(
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
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 4,
                  sections: showingSections(),
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
    );
  }
  List<PieChartSectionData> showingSections() {
    final exp = Get.find<HomeController>().expList;

    // Calculate the total amount
    final totalAmount = exp.fold(0.0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

    return List.generate(exp.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 10.0;
      final radius = isTouched ? 60.0 : 100.0;
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

// import 'package:expenditure_management/models/expenditure_model.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import '../../custom_widgets/custom_text.dart';
//
// class PieChartScreen extends StatefulWidget {
//   @override
//   _PieChartScreenState createState() => _PieChartScreenState();
// }
//
// class _PieChartScreenState extends State<PieChartScreen> {
//   int touchedIndex = -1;
//
//   List<ExpenditureModel> expL = []; // Your list of expenses
//
//   @override
//   Widget build(BuildContext context) {
//     // Group the expenses by category ID
//     Map<int, List<ExpenditureModel>> groupedExpenses = {};
//     for (var expense in expL) {
//       groupedExpenses.putIfAbsent((expense.category?.id??0), () => []).add(expense);
//     }
//
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 1.3,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       setState(() {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           touchedIndex = -1;
//                           return;
//                         }
//                         touchedIndex = pieTouchResponse
//                             .touchedSection!.touchedSectionIndex;
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 4,
//                   sections: _buildPieChartSections(groupedExpenses),
//                 ),
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * .3,
//                 width: MediaQuery.of(context).size.width * .3,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   itemCount: groupedExpenses.length,
//                   itemBuilder: (context, i) {
//                     var categoryId = groupedExpenses.keys.toList()[i];
//                     var categoryName =
//                         groupedExpenses[categoryId]!.first.category!.name;
//                     var sectionColor = _getSectionColor(categoryId);
//
//                     return Row(
//                       children: [
//                         Container(
//                           width: 20,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: sectionColor,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         CustomText(text: categoryName ?? ""),
//                       ],
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(
//             width: 28,
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<PieChartSectionData> _buildPieChartSections(
//       Map<int, List<ExpenditureModel>> groupedExpenses) {
//     return groupedExpenses.entries.map((entry) {
//       var categoryId = entry.key;
//       var expenses = entry.value;
//       var totalAmount = expenses.fold(0.0, (sum, item) => sum + (item.amount??0));
//       var sectionColor = _getSectionColor(categoryId);
//
//       return PieChartSectionData(
//         color: sectionColor,
//         value: totalAmount,
//         title: '',
//         radius: 50,
//       );
//     }).toList();
//   }
//
//   Color _getSectionColor(int categoryId) {
//     switch (categoryId) {
//       case 0:
//         return Colors.yellow;
//       case 1:
//         return Colors.purple;
//       case 2:
//         return Colors.green;
//       case 3:
//         return Colors.blue;
//       case 4:
//         return Colors.orange;
//       case 5:
//         return Colors.red;
//       case 6:
//         return Colors.pink;
//       case 7:
//         return Colors.teal;
//       case 8:
//         return Colors.cyan;
//       case 9:
//         return Colors.indigo;
//       case 10:
//         return Colors.lime;
//       case 11:
//         return Colors.brown;
//       case 12:
//         return Colors.deepOrange;
//       case 13:
//         return Colors.lightGreen;
//       case 14:
//         return Colors.lightBlue;
//       case 15:
//         return Colors.amber;
//       case 16:
//         return Colors.deepPurple;
//       case 17:
//         return Colors.blueGrey;
//       case 18:
//         return Colors.lightGreenAccent;
//       case 19:
//         return Colors.redAccent;
//       case 20:
//         return Colors.pinkAccent;
//       default:
//         return Colors.grey;
//     }
//   }
// }



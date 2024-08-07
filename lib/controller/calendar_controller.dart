import 'package:get/get.dart';

import '../models/expenditure.dart';

class CalendarController extends GetxController {
  final totalExpense = 0.obs;
  final totalIncome = 0.obs;

  final isExpense = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changeExpense() {
    isExpense.value = !isExpense.value;
  }

  void calculateTotal(List<Expenditure> expList) {
    totalExpense.value = 0;
    totalIncome.value = 0;
    for (int i = 0; i < expList.length; i++) {
      if (expList[i].expm?.type?.id == 1) {
        totalExpense.value += (expList[i].expm?.amount ?? 0);
      } else {
        totalIncome.value += (expList[i].expm?.amount ?? 0);
      }
    }
  }
}

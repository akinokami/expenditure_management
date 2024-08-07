import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expenditure.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

class CalendarController extends GetxController {
  final totalExpense = 0.obs;
  final totalIncome = 0.obs;

  final isExpense = true.obs;
  RxList<Expenditure> expList = <Expenditure>[].obs;

  final firestoreService = FireStoreService();
  final isLoading = false.obs;

  @override
  void onInit() {
    getExpenditures();
    super.onInit();
  }

  void getExpenditures() async {
    isLoading.value = true;
    try {
      expList.clear();
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      expList.addAll(result.map((e) => Expenditure.fromJson(e)).toList());
    } catch (e) {
      constants.showSnackBar(
          title: 'error'.tr, msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
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

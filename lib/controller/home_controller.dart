import 'package:collection/collection.dart';
import 'package:expenditure_management/models/expm_group.dart';
import 'package:expenditure_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expenditure.dart';
import '../models/expenditure_model.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

class HomeController extends GetxController {
  final searchTxtController = TextEditingController();
  final isLoading = false.obs;
  final firestoreService = FireStoreService();
  List<Expenditure> expList = <Expenditure>[].obs;
  List<ExpmGroup> expGroupList = <ExpmGroup>[].obs;
  List<ExpmGroup> expFilterList = <ExpmGroup>[].obs;
  List<ExpenditureModel> pieIncomeList = <ExpenditureModel>[].obs;
  List<ExpenditureModel> pieExpenseList = <ExpenditureModel>[].obs;
  Map<DateTime, List<ExpenditureModel>> grouped = {};
  @override
  void onInit() {
    getExpenditures();
    super.onInit();
  }

  void getExpenditures() async {
    isLoading(true);
    try {
      expList.clear();
      expGroupList.clear();
      pieIncomeList.clear();
      pieExpenseList.clear();
      expFilterList.clear();
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      expList.assignAll(result.map((e) => Expenditure.fromJson(e)).toList());

      for (var i = 0; i < expList.length; i++) {
        if (expList[i].expm?.type?.id == 1) {
          pieExpenseList.add(expList[i].expm!);
        } else {
          pieIncomeList.add(expList[i].expm!);
        }
      }
      var groupedItems = groupBy(expList, (Expenditure item) => item.month);
      groupedItems.forEach((key, value) {
        expGroupList.add(ExpmGroup(month: key, expList: value));
      });
      expFilterList = expGroupList;
    } catch (e) {
      constants.showSnackBar(
          title: 'error'.tr, msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void searchExpenditures() async {
    isLoading.value = true;
    expFilterList.clear();
    List<Expenditure> eList = Global.language == 'vi'
        ? expList
            .where((element) =>
                (element.expm?.category?.nameVn ?? '')
                    .toLowerCase()
                    .contains(searchTxtController.text.toLowerCase()) ||
                (element.expm?.payment?.nameVn ?? '')
                    .toLowerCase()
                    .contains(searchTxtController.text.toLowerCase()) ||
                (element.expm?.amount.toString() ?? '')
                    .contains(searchTxtController.text))
            .toList()
        : expList
            .where((element) =>
                (element.expm?.category?.name ?? '')
                    .toLowerCase()
                    .contains(searchTxtController.text.toLowerCase()) ||
                (element.expm?.payment?.name ?? '')
                    .toLowerCase()
                    .contains(searchTxtController.text.toLowerCase()) ||
                (element.expm?.amount.toString() ?? '')
                    .contains(searchTxtController.text))
            .toList();
    var groupedItems = groupBy(eList, (Expenditure item) => item.month);
    groupedItems.forEach((key, value) {
      expFilterList.add(ExpmGroup(month: key, expList: value));
    });
    isLoading.value = false;
  }
}

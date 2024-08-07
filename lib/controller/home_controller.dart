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
  // List<ExpenditureModel> expList = <ExpenditureModel>[].obs;
  List<Expenditure> expList = <Expenditure>[].obs;
  List<ExpmGroup> expGroupList = <ExpmGroup>[].obs;
  List<ExpenditureModel> searchList = <ExpenditureModel>[].obs;
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
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      expList.assignAll(result.map((e) => Expenditure.fromJson(e)).toList());
      print(expList);
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
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  // void searchExpenditures() async {
  //   isLoading(true);
  //   try {
  //     Global.docIdList.clear();
  //     List<Map<String, dynamic>> result =
  //         await firestoreService.getExpenditures();
  //     print(result);
  //     expList
  //         .assignAll(result.map((e) => ExpenditureModel.fromJson(e)).toList());
  //     searchList.addAll(expList
  //         .where((element) => ((element.category?.name ?? "")
  //                 .toLowerCase()
  //                 .contains(searchTxtController.text.toLowerCase()) ||
  //             (element.payment?.name ?? "")
  //                 .toLowerCase()
  //                 .contains(searchTxtController.text.toLowerCase())))
  //         .toList());
  //   } catch (e) {
  //     constants.showSnackBar(
  //         title: 'Error', msg: e.toString(), textColor: Colors.red);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}

import 'package:expenditure_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expenditure_model.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

class HomeController extends GetxController {
  final searchTxtController = TextEditingController();
  final isLoading = false.obs;
  final firestoreService = FireStoreService();
  List<ExpenditureModel> expList = <ExpenditureModel>[].obs;
  List<ExpenditureModel> searchList = <ExpenditureModel>[].obs;
  Map<DateTime, List<ExpenditureModel>> grouped = {};
  @override
  void onInit() {
    getExpenditures();
    super.onInit();
  }

  void getExpenditures() async {
    isLoading(true);
    try {
      Global.docIdList.clear();
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      print(result);
      expList
          .assignAll(result.map((e) => ExpenditureModel.fromJson(e)).toList());
      //_groupByDate(expList);
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  Map<DateTime, List<ExpenditureModel>> _groupByDate(
      List<ExpenditureModel> expenditures) {
    DateTime? formattedDate;

    for (var exp in expenditures) {
      DateTime date = DateTime.parse((exp.updatedDate ?? "").split(" ")[0]);
      formattedDate =
          DateTime(date.year, date.month); // Only keep year, month, day
      print("Format Home Date $formattedDate ");
      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(exp);
    }
    print("Here is grouped ${grouped}");
    expList.addAll(grouped[formattedDate]!.toList());
//print("Exp lust $expList");
    return grouped;
  }

  void searchExpenditures() async {
    isLoading(true);
    try {
      Global.docIdList.clear();
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      print(result);
      expList
          .assignAll(result.map((e) => ExpenditureModel.fromJson(e)).toList());
      searchList.addAll(expList
          .where((element) => ((element.category?.name ?? "")
                  .toLowerCase()
                  .contains(searchTxtController.text.toLowerCase()) ||
              (element.payment?.name ?? "")
                  .toLowerCase()
                  .contains(searchTxtController.text.toLowerCase())))
          .toList());
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }
}

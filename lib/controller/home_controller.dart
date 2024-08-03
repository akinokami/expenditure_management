import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expenditure_model.dart';
import '../services/firestore_service.dart';
import '../utils/constants.dart';

class HomeController extends GetxController {
  final searchTxtController = TextEditingController();
  final isLoading = false.obs;
  final firestoreService = FireStoreService();
  RxList<ExpenditureModel> expList = <ExpenditureModel>[].obs;

  @override
  void onInit() {
    getExpenditures();
    super.onInit();
  }

  void getExpenditures() async {
    isLoading(true);
    try {
      List<Map<String, dynamic>> result =
          await firestoreService.getExpenditures();
      expList
          .assignAll(result.map((e) => ExpenditureModel.fromJson(e)).toList());
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    }
    isLoading(false);
  }
}

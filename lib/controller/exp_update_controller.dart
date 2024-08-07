import 'package:expenditure_management/constants/color_const.dart';
import 'package:expenditure_management/controller/home_controller.dart';
import 'package:expenditure_management/models/expenditure_model.dart';
import 'package:expenditure_management/services/firestore_service.dart';
import 'package:expenditure_management/views/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ExpUpdateController extends GetxController {
  var tabIndex = 0.obs;
  RxBool isExpense = true.obs;

  // RxInt selectedPayment = 0.obs;

  Rx<PaymentModel> selectedPayment =
      PaymentModel(id: 1, name: "Bank", nameVn: "Ngân Hàng").obs;
  Rx<CategoryModel> selectedCategory =
      CategoryModel(id: 1, name: "Eat and Drink", nameVn: "Ăn uống").obs;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  RxString selectedDateStr = "".obs;
  RxString selectedTimeStr = "".obs;
  final isLoading = false.obs;
  final firestoreService = FireStoreService();
  final noteTxtController = TextEditingController();
  final amountTxtController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formatDate();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      formatTime();
    }
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    formatDate();
    selectedTimeStr.value = "${selectedTime.hour}:${selectedTime.minute}";
    super.onInit();
  }

  void updateInitial({ExpenditureModel? expenditureModel}) {
    print(expenditureModel?.toJson());
    amountTxtController.text = "${expenditureModel?.amount ?? ''}";
    noteTxtController.text = expenditureModel?.note ?? "";
    selectedCategory.value = expenditureModel?.category ??
        CategoryModel(id: 1, name: "Eat and Drink", nameVn: "Ăn uống");
    selectedPayment.value = expenditureModel?.payment ??
        PaymentModel(id: 1, name: "Bank", nameVn: "Ngân Hàng");
    selectedDateStr.value =
        expenditureModel?.updatedDate?.split(' ').elementAt(0) ?? "";
    selectedTimeStr.value =
        expenditureModel?.updatedDate?.split(' ').elementAt(1) ?? "";
    if (expenditureModel?.type?.id == 1) {
      tabIndex.value = 0;
      isExpense.value = true;
    } else {
      tabIndex.value = 1;
      isExpense.value = false;
    }
  }

  void formatDate() {
    if (selectedDate.day < 10 && selectedDate.month > 9) {
      selectedDateStr.value =
          "${selectedDate.year}-${selectedDate.month}-0${selectedDate.day}";
    } else if (selectedDate.month < 10 && selectedDate.day > 9) {
      selectedDateStr.value =
          "${selectedDate.year}-0${selectedDate.month}-${selectedDate.day}";
    } else if (selectedDate.day < 10 && selectedDate.month < 10) {
      selectedDateStr.value =
          "${selectedDate.year}-0${selectedDate.month}-0${selectedDate.day}";
    } else {
      selectedDateStr.value =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    }
  }

  void formatTime() {
    if (selectedTime.hour < 10 && selectedTime.minute > 9) {
      selectedTimeStr.value = "0${selectedTime.hour}:${selectedTime.minute}";
    } else if (selectedTime.hour > 9 && selectedTime.minute < 10) {
      selectedTimeStr.value = "${selectedTime.hour}:0${selectedTime.minute}";
    } else if (selectedTime.hour < 10 && selectedTime.minute < 10) {
      selectedTimeStr.value = "0${selectedTime.hour}:0${selectedTime.minute}";
    } else {
      selectedTimeStr.value = "${selectedTime.hour}:${selectedTime.minute}";
    }
  }

  void changeExpense() {
    isExpense.value = !isExpense.value;
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  void updateExpenditure({required String docId}) async {
    isLoading(true);
    try {
      await firestoreService.updateExpenditure(
          docId,
          ExpenditureModel(
            note: noteTxtController.text,
            amount: int.parse(amountTxtController.text),
            category: selectedCategory.value,
            payment: selectedPayment.value,
            type: isExpense.value == true
                ? TypeModel(id: 1, name: 'Expense', nameVn: 'Chi phí')
                : TypeModel(id: 2, name: 'Income', nameVn: 'Thu nhập'),
            createdDate: DateTime.now().toString(),
            updatedDate: "${selectedDateStr.value} ${selectedTimeStr.value}",
          ));
      Get.find<HomeController>().getExpenditures();
      constants.showSnackBar(
          title: 'Success',
          msg: "Data updated successfully.",
          textColor: secondaryColor);
      //clearData();
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void deleteExpenditure({required String docId}) {
    isLoading(true);
    try {
      firestoreService.deleteExpenditure(docId);
      Get.find<HomeController>().getExpenditures();
      constants.showSnackBar(
          title: 'Success',
          msg: "Data deleted successfully.",
          textColor: secondaryColor);
    } catch (e) {
      constants.showSnackBar(
          title: 'Error', msg: e.toString(), textColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  void clearData() {
    noteTxtController.clear();
    amountTxtController.clear();
    selectedCategory.value =
        CategoryModel(id: 1, name: "Eat and Drink", nameVn: "Ăn uống");
    selectedPayment.value =
        PaymentModel(id: 1, name: "Bank", nameVn: "Ngân Hàng");
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    formatDate();
    formatTime();
  }
}

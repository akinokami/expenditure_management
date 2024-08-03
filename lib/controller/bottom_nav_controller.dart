import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var tabIndex = 0.obs;
  RxBool isExpense = true.obs;
  RxInt selectedCategory = 0.obs;
  RxInt selectedPayment = 0.obs;
  DateTime selectedDate=DateTime.now();
  TimeOfDay selectedTime=TimeOfDay.now();
  RxString selectedDateStr="".obs;
  RxString selectedTimeStr="".obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if(selectedDate.day<10 && selectedDate.month>9){
        selectedDateStr.value = "0${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";}
      else if(selectedDate.month<10 && selectedDate.day>9){
        selectedDateStr.value = "${selectedDate.day}-0${selectedDate.month}-${selectedDate.year}";}
     else if(selectedDate.day<10 && selectedDate.month<10){
        selectedDateStr.value = "0${selectedDate.day}-0${selectedDate.month}-${selectedDate.year}";
      }
      else {
        selectedDateStr.value = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      }
    }

  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      selectedTimeStr.value = "${selectedTime.hour}:${selectedTime.minute}";
    }

  }
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    //
    super.onInit();
  }

  void changeExpense() {
    isExpense.value = !isExpense.value;
  }

  @override
  void dispose() {
    //
    super.dispose();
  }
}

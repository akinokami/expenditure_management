import 'package:get/get.dart';

class CalendarController extends GetxController {
  final isExpense = true.obs;

  void changeExpense() {
    isExpense.value = !isExpense.value;
  }
}

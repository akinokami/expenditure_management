import 'package:get/get.dart';

class ProfileController extends GetxController{
  RxDouble sliderValue = 0.0.obs;

  void setSliderValue(double value) {
    sliderValue.value = value;
  }

  String get formattedTime {
    int totalMinutes = sliderValue.value.toInt();
    int hour = totalMinutes ~/ 60;
    int minute = totalMinutes % 60;
    return hour.toString().padLeft(2, '0') + ":" + minute.toString().padLeft(2, '0');
  }
}
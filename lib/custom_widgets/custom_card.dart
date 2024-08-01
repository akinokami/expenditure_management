import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_const.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.height,
    this.width,
    this.color,
    required this.widget,
    this.cardElevation,
  });
  final double? height;
  final double? width;
  final Color? color;
  final Widget widget;
  final double? cardElevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      // ),
      elevation: cardElevation ?? 5.h,
      child: Container(
        padding: EdgeInsets.all(10.w),
        height: height,
        width: width,
        color: color ?? cardColor,
        child: widget,
      ),
    );
  }
}

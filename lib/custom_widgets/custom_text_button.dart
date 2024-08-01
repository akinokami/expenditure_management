import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_const.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.width,
      this.fontSize});
  final String text;
  final void Function() onPressed;
  final Color? color;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: 50.h,
      child: MaterialButton(
        onPressed: onPressed,
        color: color ?? secondaryColor,
        child: CustomText(
          text: text,
          color: color ?? Colors.white,
          fontSize: fontSize ?? 12.sp,
        ),
      ),
    );
  }
}

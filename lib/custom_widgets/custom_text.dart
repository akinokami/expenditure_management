import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.textOverflow,
      this.maxLines,
      this.fontFamily});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLines ?? 1,
        style: TextStyle(
          fontSize: fontSize ?? 12.sp,
          color: color ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? 'Poppins',
          overflow: textOverflow ?? TextOverflow.ellipsis,
        ));
  }
}

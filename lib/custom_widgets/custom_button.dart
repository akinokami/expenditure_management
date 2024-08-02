import 'package:expenditure_management/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? size;
  final Color? txtColor;
  final Color? bgColor;
  final Color? outlineColor;
  final Color? shadowColor;
  final bool? isRounded;
  final double? width;
  final double? height;
  final IconData? icon;
  final String? image;
  final void Function()? onTap;

  const CustomButton(
      {super.key,
      required this.text,
      this.size,
      this.txtColor,
      this.bgColor,
      this.outlineColor,
      this.shadowColor,
      this.isRounded,
      this.width,
      this.height,
      this.icon,
      this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 40,
        decoration: BoxDecoration(
          border: Border.all(color: outlineColor ?? Colors.green, width: 2),
          borderRadius: isRounded == true
              ? BorderRadius.circular(100)
              : BorderRadius.circular(5),
          color: bgColor ?? Colors.green,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: Colors.white),
              ),
            ),
            Visibility(
              visible: image != null,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(image ?? ''),
              ),
            ),
            CustomText(
              text: text,
              color: txtColor ?? Colors.white,
              fontSize: size ?? 16.sp,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}

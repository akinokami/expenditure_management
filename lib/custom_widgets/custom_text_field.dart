import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.height,
      this.hintColor,
      this.fillColor,
      this.hintText,
      this.borderRadius,
      this.enabled,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete});
  final TextEditingController controller;
  final double? height;
  final Color? hintColor;
  final Color? fillColor;
  final String? hintText;
  final double? borderRadius;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.h,
      child: TextField(
        controller: controller,
        enabled: enabled ?? true,
        onChanged: onChanged ?? (value) {},
        onSubmitted: onSubmitted ?? (value) {},
        onEditingComplete: onEditingComplete ?? () {},
        decoration: InputDecoration(
          hintText: hintText ?? '',
          fillColor: fillColor ?? Colors.white,
          hintStyle: TextStyle(
            color: hintColor ?? Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

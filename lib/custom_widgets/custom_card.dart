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


// import 'package:flutter/material.dart';
// import 'package:iot/styles/app_colors.dart';

// class CustomCard extends StatelessWidget {
//   final Widget? widget;
//   const CustomCard({super.key, this.widget});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: AppColors.grey,
//             spreadRadius: 1,
//             blurRadius: 2,
//             offset: Offset(0, 0),
//           ),
//         ],
//       ),
//       child: widget ?? const SizedBox(),
//     );
//   }
// }

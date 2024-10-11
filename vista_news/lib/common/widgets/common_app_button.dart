import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista_news/common/constants/app_colors.dart';

class CommonAppButton extends StatelessWidget {
  const CommonAppButton(
      {super.key, this.buttonAction, required this.buttonName});
  final Function()? buttonAction;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.themeColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: buttonAction,
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold),
        ));
  }
}

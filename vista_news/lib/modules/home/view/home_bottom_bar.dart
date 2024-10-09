import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';

class HomePageBottomBar extends StatelessWidget {
  const HomePageBottomBar({super.key, required this.currentPage});
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.all_inclusive),
          label: 'all News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favorites News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save_outlined),
          label: 'Saved News',
        ),
      ],
      currentIndex: currentPage,
      onTap: (int selectedIndex) =>
          context.read<HomeBloc>().add(ChangeTabEvent(tabIndex: selectedIndex)),
      backgroundColor: AppColors.themeColor,
      unselectedItemColor: AppColors.greyColor,
      unselectedLabelStyle:
          TextStyle(color: AppColors.greyColor, fontSize: 10.sp),
      selectedLabelStyle:
          TextStyle(color: AppColors.themeColor, fontSize: 10.sp),
      unselectedIconTheme:
          IconThemeData(color: AppColors.greyColor, size: 25.sp),
      selectedItemColor: AppColors.whiteColor,
      selectedFontSize: 13.sp,
      selectedIconTheme:
          IconThemeData(color: AppColors.whiteColor, size: 25.sp),
    );
  }
}

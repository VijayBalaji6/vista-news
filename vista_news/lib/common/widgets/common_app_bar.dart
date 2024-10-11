import 'package:flutter/material.dart';
import 'package:vista_news/common/constants/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key, this.leadingWidget, this.titleWidget, this.trailingWidgets});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      elevation: 0,
      title: titleWidget,
      centerTitle: false,
      leading: leadingWidget,
      actions: trailingWidgets,
    );
  }
}

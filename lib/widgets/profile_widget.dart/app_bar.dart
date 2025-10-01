import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/res/media_querry/media_query.dart'; // Import your extension

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? previousPageTitle;
  final VoidCallback? onBack;
  final bool transitionBetweenRoutes;

  const CustomAppBar({
    super.key,
    required this.title,
    this.previousPageTitle,
    this.onBack,
    this.transitionBetweenRoutes = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      key: const Key('CustomAppBar'),
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
          Icons.arrow_back,
          color: AppColors.textspan,
          size: context.widthPct(0.05), // responsive icon size
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      middle: Text(
        title,
        style: AppTextStyles.h4(context).copyWith(
        
        ),
      ),
      previousPageTitle: previousPageTitle,
      transitionBetweenRoutes: transitionBetweenRoutes,
      heroTag: "CustomAppBar",
      backgroundColor: AppColors.white,
      border: Border(
        bottom: BorderSide(
          color: AppColors.gray,
          width: context.heightPct(0.0015), // responsive border thickness
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
  final screenHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  return Size.fromHeight(screenHeight * 0.8); // 8% of screen height
}
}

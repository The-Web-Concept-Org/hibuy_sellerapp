import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: context.heightPct(57 / 812),  // ~7% of screen height
        padding: EdgeInsets.all(context.widthPct(16 / 375)), // 16px → responsive
        decoration: BoxDecoration(
          color: AppColors.primaryColor, // background
          borderRadius: BorderRadius.circular(context.widthPct(5 / 375)), // 5px → responsive
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.25), 
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.buttontext(context)
          ),
        ),
      ),
    );
  }
}

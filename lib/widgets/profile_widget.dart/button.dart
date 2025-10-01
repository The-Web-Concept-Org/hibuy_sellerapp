import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPct(0.9), // ~343px
      height: context.heightPct(0.05), // ~39px
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(context.widthPct(0.05)), // ~20px
        border: Border.all(color: AppColors.white, width: 1),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: context.heightPct(0.012), // ~10px
            //horizontal: context.widthPct(0.40), // ~152px
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:AppTextStyles.buttontext(context)
        ),
      ),
    );
  }
}
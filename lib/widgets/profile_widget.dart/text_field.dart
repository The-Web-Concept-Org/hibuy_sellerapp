import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? trailingIcon;
  final VoidCallback? onIconTap;
  final Color? iconColor;
  final String? Function(String?)? validator;

  // ✅ Added Focus
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;

  const ReusableTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.trailingIcon,
    this.onIconTap,
    this.iconColor,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,  // default "Next"
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.bodyRegular(context),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          width: double.maxFinite,
          height: context.heightPct(0.06),
          padding: EdgeInsets.symmetric(
            horizontal: context.widthPct(0.043),
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(context.widthPct(0.013)),
            border: Border.all(color: AppColors.stroke, width: 1),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  focusNode: focusNode,
                  textInputAction: textInputAction,
                  onFieldSubmitted: (_) {
                    if (nextFocusNode != null) {
                      FocusScope.of(context).requestFocus(nextFocusNode);
                    } else {
                      FocusScope.of(context).unfocus(); // last field
                    }
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
              if (trailingIcon != null)
                GestureDetector(
                  onTap: onIconTap,
                  child: Icon(
                    trailingIcon,
                    size: context.widthPct(0.05),
                    color: iconColor ??
                        AppColors.secondry.withOpacity(0.50),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

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
  final Widget? trailingWidget;
  final Widget? sufixWidget;
  final VoidCallback? onIconTap;
  final VoidCallback? onTrailingWidgetTap;
  final VoidCallback? onSufixWidgetTap;
  final Color? iconColor;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

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
    this.textInputAction = TextInputAction.next,
    this.trailingWidget,
    this.onTrailingWidgetTap,
    this.sufixWidget,
    this.onSufixWidgetTap, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(labelText!, style: AppTextStyles.bodyRegular(context)),
          ),

        Container(
          width: double.maxFinite,
          height: context.heightPct(0.05),
          padding: EdgeInsets.only(
            left: context.widthPct(0.043),
            right: trailingWidget != null ? 0 : context.widthPct(0.043),
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(context.widthPct(0.013)),
            border: Border.all(color: AppColors.stroke, width: 1),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              if (sufixWidget != null)
                GestureDetector(
                  onTap: onSufixWidgetTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: sufixWidget,
                  ),
                ),
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
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppTextStyles.normal(context),
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
                    color: iconColor ?? AppColors.secondry.withOpacity(0.50),
                  ),
                ),
              if (trailingWidget != null)
                GestureDetector(
                  onTap: onTrailingWidgetTap,
                  child: trailingWidget,
                ),
                
            ],
            
          ),
          
        ),
        
      ],
      
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class AppTextStyles {
  static TextStyle h4(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(16),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle bold2(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(16),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
  static TextStyle bodyRegular(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle Bold(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(18),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle bold4(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle buttontext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
  static TextStyle ortext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle linktext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.primaryColor,
  );
  static TextStyle TextSpan(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.textspan,
  );
  static TextStyle normal(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.textspan.withOpacity(0.50),
  );
  static TextStyle greytext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.gray,
  );
  static TextStyle samibold(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(11.43),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.primaryColor,
  );
  static TextStyle samibold2(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
  static TextStyle samibold5(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(19),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.red,
  );
  static TextStyle greytext2(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.gray2,
  );
  static TextStyle normalbold(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.primaryColor,
  );
  static TextStyle unselect(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle cardtext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(9),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black2,
  );
  static TextStyle cardvalue(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(15),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black2,
  );
  static TextStyle allproducts(BuildContext context) => GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
  static TextStyle boostedproducts(BuildContext context) => GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle searchtext(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry.withOpacity(0.50),
  );
  static TextStyle medium(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
  static TextStyle medium2(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
  static TextStyle regular(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(8),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.primaryColor,
  );
  static TextStyle samibold3(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle regular2(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(8),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry.withOpacity(0.25),
  );
  static TextStyle samibold4(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: context.scaledFont(16),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black3,
  );
  static TextStyle medium3(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle medium4(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry.withOpacity(0.50),
  );
  static TextStyle heading(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
  static TextStyle regular4(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
  static TextStyle regular5(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: context.scaledFont(9),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle settingtab(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(10),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.secondry,
  );
  static TextStyle referal(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.dark,
  );
    static TextStyle medium5(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(13),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
      static TextStyle medium6(BuildContext context) => GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(13),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
    static TextStyle boldlato(BuildContext context) => GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: context.scaledFont(14),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black4,
  );
     static TextStyle medium7(BuildContext context) => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: context.scaledFont(12),
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.black4,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/bottomnavbar_bloc/bottom_nav_bloc.dart';
import 'package:hibuy/Bloc/bottomnavbar_bloc/bottom_nav_event.dart';
import 'package:hibuy/Bloc/bottomnavbar_bloc/bottom_nav_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class BottomNabBar extends StatelessWidget {
  const BottomNabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        if (state is BottomNavInitial) {
          return Scaffold(
            body: state.screen,
            bottomNavigationBar: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: const Border(
                  top: BorderSide(color: AppColors.stroke, width: 1),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                currentIndex: state.index,
                onTap: (index) {
                  context.read<BottomNavBloc>().add(
                    BottomNavItemSelected(index),
                  );
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.secondry,
                showUnselectedLabels: true,
                selectedLabelStyle: AppTextStyles.normalbold(context),
                unselectedLabelStyle: AppTextStyles.unselect(context),
                items: [
                  _navItem(
                    context,
                    iconPath: ImageAssets.dashboard,
                    label: AppStrings.dashboard,
                    isSelected: state.index == 0,
                  ),
                  _navItem(
                    context,
                    iconPath: ImageAssets.products,
                    label: AppStrings.products,
                    isSelected: state.index == 1,
                  ),
                  _navItem(
                    context,
                    iconPath: ImageAssets.mystore,
                    label: AppStrings.mystore,
                    isSelected: state.index == 2,
                  ),
                  _navItem(
                    context,
                    iconPath: ImageAssets.order,
                    label: AppStrings.orders,
                    isSelected: state.index == 3,
                  ),
                  _navItem(
                    context,
                    iconPath: ImageAssets.menu,
                    label: AppStrings.menu,
                    isSelected: state.index == 4,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  BottomNavigationBarItem _navItem(
    BuildContext context, {
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: context.heightPct(18 / 812),
        width: context.widthPct(18 / 375),
        fit: BoxFit.contain,
        color: isSelected ? AppColors.primaryColor : AppColors.secondry,
      ),
      label: label,
      tooltip: "",
    );
  }
}

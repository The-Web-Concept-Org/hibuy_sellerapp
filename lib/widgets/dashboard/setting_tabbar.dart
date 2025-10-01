import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_bloc.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_event.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_state.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';


class CustomTabBar extends StatelessWidget {
  final List<String> tabs;

  const CustomTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is TabChanged) {
          selectedIndex = state.selectedIndex;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () =>
                  context.read<TabBloc>().add(TabSelected(index)),
              child: Container(
                width: context.widthPct(83.81/375),
                height: context.heightPct(15/812),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:  AppColors.stroke , width: 1),
                ),
                child: Text(
                  tabs[index],
                  style:  isSelected ? AppTextStyles.allproducts(context) : AppTextStyles.settingtab(context),
                
                 
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

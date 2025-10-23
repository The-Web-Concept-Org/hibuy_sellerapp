import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_bloc.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

import 'package:hibuy/view/menu_screens/password_setting.dart';
import 'package:hibuy/view/menu_screens/profile_setting.dart';
import 'package:hibuy/view/menu_screens/referal_setting.dart';
import 'package:hibuy/widgets/dashboard/setting_tabbar.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  final List<String> tabs = const ["Profile", "Password", "My Referrals"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.addproduct,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          top: context.heightPct(12 / 812),
        ),
        child: Column(
          children: [
            CustomTabBar(tabs: tabs),
            const SizedBox(height: 20),

            // 👇 Different screens based on tab
            Expanded(
              child: BlocBuilder<TabBloc, TabState>(
                builder: (context, state) {
                  if (state is TabChanged) {
                    switch (state.selectedIndex) {
                      case 0:
                        return const ProfileSetting();
                      case 1:
                        return const PasswordSetting();
                      case 2:
                        return const ReferalSetting();
                    }
                  }
                  return const ProfileSetting(); // default
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

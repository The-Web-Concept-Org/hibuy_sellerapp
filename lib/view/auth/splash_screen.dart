import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/services/api_key.dart';
import 'package:hibuy/services/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  /// ✅ Check if token exists in SharedPreferences
  Future<void> _checkLogin() async {
    String? token = await LocalStorage.getData(key: AppKeys.authToken);

    Timer(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        // Agar token hai to KYC screen
        Navigator.pushReplacementNamed(context, RoutesName.kycstatusscreen);
      } else {
        // Agar token nahi hai to select_type
        Navigator.pushReplacementNamed(context, RoutesName.selectType);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            ImageAssets.app_logo,
            height: context.heightPct(0.25),
            width: context.widthPct(0.5), // fixed width
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

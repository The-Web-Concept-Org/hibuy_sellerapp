import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';

import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/auth/button.dart';
import 'package:hibuy/widgets/auth/text_field.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.06)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.heightPct(0.12)),
              Center(child: Image.asset(ImageAssets.app_logo2)),

              SizedBox(height: context.heightPct(0.018)),

              Text(
                AppStrings.welcometoHiBuyO,
                style: AppTextStyles.h4(context),
              ),
              SizedBox(height: context.heightPct(0.01)),
              Text(
                AppStrings.signintocontinue,
                style: AppTextStyles.bodyRegular(context),
              ),

              SizedBox(height: context.heightPct(0.02)),

              /// Email Field
              CustomTextField(
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
                controller: emailController,
              ),

              SizedBox(height: context.heightPct(0.02)),

              /// Password Field
              CustomTextField(
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                controller: passwordController,
                isPassword: true,
              ),

              SizedBox(height: context.heightPct(0.02)),

              /// BlocConsumer handles both UI + Side effects
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.success) {
                    Navigator.pushNamed(context, RoutesName.kycMain);
                  } else if (state.authStatus == AuthStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? "Login failed"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    text: state.authStatus == AuthStatus.loading
                        ? "Loading..."
                        : AppStrings.signin,
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: context.heightPct(0.02)),

              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.stroke)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      AppStrings.ortext,
                      style: AppTextStyles.ortext(context),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.stroke)),
                ],
              ),

              SizedBox(height: context.heightPct(0.02)),

              GestureDetector(
                onTap: () {
                  debugPrint("Forgot Password clicked");
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: AppTextStyles.linktext(context),
                ),
              ),

              SizedBox(height: context.heightPct(0.02)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.donthaveanaccount,
                    style: AppTextStyles.TextSpan(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signupScreen);
                    },
                    child: Text(
                      AppStrings.register,
                      style: AppTextStyles.linktext(context),
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.heightPct(0.05)),
            ],
          ),
        ),
      ),
    );
  }
}

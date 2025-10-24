import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart'
    show AuthState, AuthStatus;
import 'package:hibuy/view/auth/signin_screen.dart';
import 'package:hibuy/widgets/auth/button.dart';

import 'package:hibuy/widgets/auth/text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key, required this.role});
  final String role;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          height: context.screenHeight,
          padding: EdgeInsets.symmetric(
            horizontal: 20, // ~22px padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo
              SizedBox(height: context.heightPct(0.12)),
              Center(child: Image.asset(ImageAssets.app_logo2)),

              SizedBox(height: context.heightPct(0.018)),

              /// Welcome Text
              Text(
                AppStrings.welcometoHiBuyO,
                style: AppTextStyles.h4(context),
              ),
              SizedBox(height: context.heightPct(0.01)),
              Text(
                AppStrings.signuptocontinue,
                style: AppTextStyles.bodyRegular(context),
              ),

              SizedBox(height: context.heightPct(0.015)),

              /// username Field
              CustomTextField(
                hintText: "Username",
                prefixIcon: Icons.person_outline,
                controller: usernameController,
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

              SizedBox(height: context.heightPct(0.018)),

              /// Sign In Button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.error) {
                    // Show error message
                    // context.FlushBarErrorMessage(message: state.errorMessage ?? 'An error occurred');
                  } else if (state.authStatus == AuthStatus.success) {
                    // Navigate to another screen or show success message
                    // Navigator.pushNamed(context, RoutesName.signinScreen);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
                  }
                },
                builder: (context, state) {
                  return state.authStatus == AuthStatus.loading
                      ? CircularProgressIndicator()
                      : PrimaryButton(
                          text: AppStrings.signup,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                name: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                role: role, // Pass the role here
                              ),
                            );
                          },
                        );
                },
              ),

              SizedBox(height: context.heightPct(0.01)),

              /// Divider OR
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
              SizedBox(height: context.heightPct(0.01)),

              /// Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.donthaveanaccount,
                    style: AppTextStyles.TextSpan(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, RoutesName.signinScreen);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
                      debugPrint("Register clicked");
                    },
                    child: Text(
                      AppStrings.login,
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

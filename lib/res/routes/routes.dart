// import 'package:flutter/material.dart';
// import 'package:hibuy/res/routes/routes_name.dart';
// import 'package:hibuy/view/bottom_navigation_bar/bottom_nab_bar.dart';
// import 'package:hibuy/view/dashboard_screen/addproduct_screen.dart';
// import 'package:hibuy/view/dashboard_screen/dashboard_home_screen.dart';
// import 'package:hibuy/view/dashboard_screen/edit_profile.dart';
// import 'package:hibuy/view/dashboard_screen/order_details_screen.dart';
// import 'package:hibuy/view/dashboard_screen/product_details.dart';
// import 'package:hibuy/view/menu_screens/boost_product.dart';
// import 'package:hibuy/view/menu_screens/inquiries_screen.dart';
// import 'package:hibuy/view/menu_screens/otherproduct_screen.dart';
// import 'package:hibuy/view/menu_screens/password_setting.dart';
// import 'package:hibuy/view/menu_screens/profile_setting.dart';
// import 'package:hibuy/view/menu_screens/purchases_screen.dart';
// import 'package:hibuy/view/menu_screens/queries_screen.dart';
// import 'package:hibuy/view/menu_screens/referal_setting.dart';
// import 'package:hibuy/view/menu_screens/returnorder_screen.dart';
// import 'package:hibuy/view/menu_screens/salereport_screen.dart';
// import 'package:hibuy/view/menu_screens/setting_screen.dart';
// import 'package:hibuy/view/profile_information.dart/bank_account_screen.dart';
// import 'package:hibuy/view/profile_information.dart/business_verification_screen.dart';
// import 'package:hibuy/view/profile_information.dart/document_verification_screen.dart';
// import 'package:hibuy/view/profile_information.dart/kyc_main.dart';
// import 'package:hibuy/view/profile_information.dart/kyc_status_screen.dart';
// import 'package:hibuy/view/profile_information.dart/personal_info_screen.dart';
// import 'package:hibuy/view/profile_information.dart/store_info_screen.dart';
// import 'package:hibuy/view/auth/select_type.dart';
// import 'package:hibuy/view/auth/signin_screen.dart';
// import 'package:hibuy/view/auth/signup_screen.dart';
// import 'package:hibuy/view/auth/splash_screen.dart';

// class AppRoutes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       // Authcation
//       case RoutesName.splash:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => const SplashScreen(),
//         );
//       case RoutesName.selectType:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => const SelectType(),
//         );
//       case RoutesName.signinScreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => SigninScreen(),
//         );
//       case RoutesName.signupScreen:
//         final role = settings.arguments as String;
//         return MaterialPageRoute(
//           builder: (BuildContext context) => SignupScreen(role: role),
//         );

//       // profile
//       case RoutesName.kycMain:
//         return MaterialPageRoute(builder: (BuildContext context) => KycMain());
//       case RoutesName.personalinformation:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => PersonalInfoScreen(),
//         );
//       case RoutesName.bankAccountVerification:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => BankAccountScreen(),
//         );
//       case RoutesName.businessVerification:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => BusinessVerificationScreen(),
//         );
//       case RoutesName.documentVerification:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => DocumentVerificationScreen(),
//         );
//       case RoutesName.myStoreInformation:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => StoreInfoScreen(),
//         );
//       case RoutesName.bottomnabBar:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => BottomNabBar(),
//         );
//       case RoutesName.addproductscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => AddproductScreen(),
//         );
//       case RoutesName.editprofile:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => EditProfile(),
//         );
//       case RoutesName.productdetailscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => ProductDetailScreen(),
//         );
//       case RoutesName.boostProductsscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => BoostProduct(),
//         );
//       case RoutesName.settingscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => SettingScreen(),
//         );
//       case RoutesName.returnorderscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => ReturnorderScreen(),
//         );
//       case RoutesName.otherproductscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => OtherproductScreen(),
//         );

//       case RoutesName.purchasesscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => PurchasesScreen(),
//         );
//       case RoutesName.inquiriesscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => InquiriesScreen(),
//         );

//       case RoutesName.queriesscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => QueriesScreen(),
//         );
//       case RoutesName.saleReportscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => SalereportScreen(),
//         );
//       case RoutesName.password:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => PasswordSetting(),
//         );
//       case RoutesName.profile:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => ProfileSetting(),
//         );
//       case RoutesName.myreferals:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => ReferalSetting(),
//         );
//       case RoutesName.kycstatusscreen:
//         return MaterialPageRoute(
//           builder: (BuildContext context) => KycStatusScreen(),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (_) {
//             return const Scaffold(
//               body: Center(child: Text('No route defined')),
//             );
//           },
//         );
//     }
//   }
// }

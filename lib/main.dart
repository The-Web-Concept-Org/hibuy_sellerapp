import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/bottomnavbar_bloc/bottom_nav_bloc.dart';
import 'package:hibuy/Bloc/droupdown_list/dropdown_bloc.dart';
import 'package:hibuy/Bloc/droupdown_list/dropdown_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_bloc.dart';

import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_bloc.dart';
import 'package:hibuy/Bloc/setting_tab_bloc.dart/tab_bloc.dart';

import 'package:hibuy/res/routes/routes.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/kyc_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StepBloc()),
        BlocProvider(create: (_) => BottomNavBloc()),
        BlocProvider(create: (_) => ProductDetailBloc()),
        BlocProvider(create: (_) => TabBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ImagePickerBloc()),
        BlocProvider(create: (_) => DropdownBloc()),
        BlocProvider(create: (_) => KycBloc()),
        BlocProvider(create: (_) => StoreDetailsBloc()),
         BlocProvider(create: (_) => StoreBloc()),
         BlocProvider(create: (_) => ProductCategoryBloc()),
        BlocProvider(create: (_) => VehicleTypeBloc()),
         BlocProvider(create: (context) => VariantBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiBuy',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,

      // 🔑 Important for DevicePreview
      // useInheritedMediaQuery: true,
      // builder: DevicePreview.appBuilder,
      // locale: DevicePreview.locale(context),
      initialRoute: RoutesName.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

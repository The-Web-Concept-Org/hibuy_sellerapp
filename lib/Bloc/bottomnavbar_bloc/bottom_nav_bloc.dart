import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';
import 'package:hibuy/view/dashboard_screen/dashboard_home_screen.dart';
import 'package:hibuy/view/dashboard_screen/product_screen.dart';
import 'package:hibuy/view/dashboard_screen/mystore_screen.dart';
import 'package:hibuy/view/dashboard_screen/order_screen.dart';
import 'package:hibuy/view/dashboard_screen/menu_screen.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  final List<Widget> _screens = [
    const DashboardHomeScreen(),
    const ProductScreen(),
    const MystoreScreen(),
    const OrderScreen(),
    MenuScreen(),
  ];

  BottomNavBloc() : super(BottomNavInitial(index: 0, screen: const DashboardHomeScreen())) {
    on<BottomNavItemSelected>((event, emit) {
      emit(BottomNavInitial(index: event.index, screen: _screens[event.index]));
    });
  }
}

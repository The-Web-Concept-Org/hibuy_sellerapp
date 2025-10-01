import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();

  @override
  List<Object> get props => [];
}

class BottomNavInitial extends BottomNavState {
  final int index;
  final Widget screen;

  const BottomNavInitial({required this.index, required this.screen});

  @override
  List<Object> get props => [index, screen];
}

import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
  
}

class FetchProductListEvent extends ProductListEvent {}
class SetTabBarEvent extends ProductListEvent {
  final int selectedIndex;
  const SetTabBarEvent({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

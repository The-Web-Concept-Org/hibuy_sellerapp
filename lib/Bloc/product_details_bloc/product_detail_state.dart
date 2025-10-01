import 'package:equatable/equatable.dart';

class ProductDetailState extends Equatable {
  final int selectedIndex;

  const ProductDetailState({
    this.selectedIndex = 0,
  });

  ProductDetailState copyWith({
    int? selectedIndex,
  }) {
    return ProductDetailState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}

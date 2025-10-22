import 'package:equatable/equatable.dart';
import 'package:hibuy/models/addproduct_model.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class SubmitAddProductEvent extends AddProductEvent {
  final AddProduct product;

  const SubmitAddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

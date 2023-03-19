import 'package:equatable/equatable.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_item.dart';

class GroceriesList extends Equatable {
  GroceriesList({required this.title, this.id});

  final int? id;

  final String title;

  final List<GroceriesItem> items = [];

  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}
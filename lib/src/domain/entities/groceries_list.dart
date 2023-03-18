import 'package:shopper/src/domain/entities/groceries_item.dart';

abstract class GroceriesList {
  GroceriesList({required this.title, this.id});

  int? id;

  String title;

  List<GroceriesItem> items = [];
}
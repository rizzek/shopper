
import 'package:shopper/src/domain/entities/groceries_item.dart';
import 'package:shopper/src/domain/entities/groceries_list.dart';

class LocalGroceriesList implements GroceriesList {
  LocalGroceriesList({required this.title, this.id});

  @override
  int? id;

  @override
  String title;

  @override
  List<GroceriesItem> items = [];
}
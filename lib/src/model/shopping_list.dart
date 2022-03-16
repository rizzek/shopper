
import 'package:shopper/src/model/shopping_item.dart';

class ShoppingList {
  ShoppingList({required this.title, this.id});

  int? id;

  String title;

  List<ShoppingItem> items = [];
}
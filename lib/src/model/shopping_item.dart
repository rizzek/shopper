
import 'package:shopper/src/domain/entities/groceries_item.dart';

class LocalGroceriesItem implements GroceriesItem {
  LocalGroceriesItem(this.label, this.completed, this.id);

  @override
  String label;

  @override
  bool completed;

  @override
  int? id;

  @override
  String toString() {
    return "ShoppingItem(id: $id, label: $label, completed: $completed)";
  }
}

class ShoppingItem {
  ShoppingItem(this.label, this.completed, this.id);

  String label;

  bool completed;

  int? id;

  @override
  String toString() {
    return "ShoppingItem(id: $id, label: $label, completed: $completed)";
  }
}
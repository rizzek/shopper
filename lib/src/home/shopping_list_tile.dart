
import 'package:flutter/material.dart';
import 'package:shopper/src/model/shopping_item.dart';

class ShoppingListTile extends StatefulWidget {
  ShoppingListTile({Key? key, required this.shoppingItem}) : super(key: key);

  ShoppingItem shoppingItem;

  @override
  State<ShoppingListTile> createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {
  @override
  Widget build(BuildContext context) {
    final TextStyle style;
    if (widget.shoppingItem.completed) {
      style = const TextStyle(decoration: TextDecoration.lineThrough);
    } else {
      style = const TextStyle();
    }

    return CheckboxListTile(
      title: Text(widget.shoppingItem.label, style: style,),
      value: widget.shoppingItem.completed,
      onChanged: (checked) {
        setState(() {
          widget.shoppingItem.completed = checked ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

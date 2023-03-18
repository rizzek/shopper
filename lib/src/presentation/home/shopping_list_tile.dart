
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/src/app_state/shopper_app_state.dart';
import 'package:shopper/src/domain/entities/groceries_item.dart';
import 'package:shopper/src/model/shopping_item.dart';

class ShoppingListTile extends StatelessWidget {
  const ShoppingListTile({Key? key, required this.shoppingItem}) : super(key: key);

  final GroceriesItem shoppingItem;


  @override
  Widget build(BuildContext context) {
    final TextStyle style;
    if (shoppingItem.completed) {
      style = const TextStyle(decoration: TextDecoration.lineThrough);
    } else {
      style = const TextStyle();
    }

    return CheckboxListTile(
      title: Text(shoppingItem.label, style: style,),
      value: shoppingItem.completed,
      onChanged: (checked) {
          shoppingItem.completed = checked ?? false;
          context.read<ShopperAppState>().updateItem(shoppingItem);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

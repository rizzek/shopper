import 'package:flutter/material.dart';
import 'package:shopper/src/model/shopping_item.dart';

class EditableShoppingListTile extends StatefulWidget {
  EditableShoppingListTile({Key? key, required this.shoppingItem, required this.onEnter})
      : super(key: key);

  ShoppingItem shoppingItem;

  VoidCallback onEnter;

  @override
  State<EditableShoppingListTile> createState() =>
      _EditableShoppingListTileState();
}

class _EditableShoppingListTileState extends State<EditableShoppingListTile> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.shoppingItem.label);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style;
    if (widget.shoppingItem.completed) {
      style = const TextStyle(decoration: TextDecoration.lineThrough);
    } else {
      style = const TextStyle();
    }


    return CheckboxListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 400,
          child: TextField(
            controller:_controller,
            focusNode: _focusNode,
            style: style,
            // decoration: InputDecoration(
            //   constraints: BoxConstraints(maxWidth: 200),
            // ),
            onChanged: (text) {
              widget.shoppingItem.label = text;
              print("Value changed!");
            },
            onSubmitted: (text) {
              print("Enter pressed!");
            },
          ),
        ),
      ),
      value: widget.shoppingItem.completed,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide(color: Colors.red)),
      onChanged: null,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

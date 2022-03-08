import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shopper/src/main_menu/main_menu.dart';
import 'package:shopper/src/model/shopping_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ShoppingItem> items = [
    ShoppingItem("Äpfel 🍎", false, 0),
    ShoppingItem("Bananen 🍌", false, 1),
    ShoppingItem("Honigkuchen 🍯", false, 2),
    ShoppingItem("Bier 🍺", false, 3),
    ShoppingItem("Saft 🧃", false, 4),
  ];

  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {

      final width = constraints.maxWidth;

      final Drawer? drawer;
      final Widget body;

      if (width > 600) {
        drawer = null;
        body = Row(
          children: [
            const SizedBox(child: MenuList(), width: 250,),
            VerticalDivider(width: 1,),
            Expanded(child: _buildShoppingList()),
          ],
        );
      } else {
        drawer = const Drawer(child: MenuList(),);
        body = _buildShoppingList();
      }

      return Scaffold(
        drawer: drawer,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
          actions: [
            if (!_editMode)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _toggleEditMode();
                },
              ),
            if (_editMode)
              TextButton(
                child: Text(AppLocalizations.of(context)!.doneButtonLabel),
                onPressed: () {
                  _toggleEditMode();
                },
              ),
          ],
        ),
        body: body,
      );
    });
  }

  Widget _buildShoppingList() {
    return ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);

        },
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final TextStyle style;
          if (item.completed) {
            style = const TextStyle(decoration: TextDecoration.lineThrough);
          } else {
            style = const TextStyle();
          }

          return CheckboxListTile(

            key: ValueKey(item.id),
            title: Text(item.label, style: style,),
            value: item.completed,
            onChanged: (checked) {
              setState(() {
                item.completed = checked ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        });
  }


  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }
}

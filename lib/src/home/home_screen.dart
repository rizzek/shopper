import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed('settings');
            },
          ),
        ],
      ),
      body: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
          /*
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
           */
        },
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CheckboxListTile(

              key: ValueKey(item.id),
              title: Text(item.label),
              value: item.completed,
              onChanged: (checked) {
                setState(() {
                  item.completed = checked ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
    );
  }
}

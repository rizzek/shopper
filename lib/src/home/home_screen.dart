import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shopper/src/app_state/shopper_app_state.dart';
import 'package:shopper/src/home/editable_shopping_list_tile.dart';
import 'package:shopper/src/home/shopping_list_tile.dart';
import 'package:shopper/src/main_menu/main_menu.dart';
import 'package:shopper/src/model/shopping_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            const SizedBox(
              child: MenuList(),
              width: 250,
            ),
            const VerticalDivider(
              width: 1,
            ),
            Expanded(child: _buildShoppingList(context)),
          ],
        );
      } else {
        drawer = const Drawer(
          child: MenuList(),
        );
        body = _buildShoppingList(context);
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
                child: Text(AppLocalizations.of(context)!.doneButtonLabel,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
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

  Widget _buildShoppingList(BuildContext context) {
    return Consumer<ShopperAppState>(
      builder: (context, state, child) {
        final items = state.listItems;
        return CustomScrollView(
          slivers: [
            ReorderableSliverList(
                delegate: ReorderableSliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    if (_editMode) {
                      return EditableShoppingListTile(
                        key: ValueKey(item.id),
                        shoppingItem: item,
                        onEnter: () {},
                      );
                    } else {
                      return ShoppingListTile(
                          key: ValueKey(item.id), shoppingItem: item);
                    }
                  },
                  childCount: items.length,
                ),
                onReorder: (oldIndex, newIndex) {
                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);

                  context.read<ShopperAppState>().updateItemPositions(items);
                }),
            if (_editMode)
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 72.0, bottom: 48.0),
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<ShopperAppState>().addItem();
                        },
                        child: const Text("add")),
                  ),
                ),
              ),

            // ReorderableListView.builder(
            //     shrinkWrap: true,
            //     physics: const ClampingScrollPhysics(),
            //     onReorder: (oldIndex, newIndex) {
            //       if (oldIndex < newIndex) {
            //         newIndex -= 1;
            //       }
            //       final item = items.removeAt(oldIndex);
            //       items.insert(newIndex, item);
            //     },
            //     itemCount: items.length,
            //     itemBuilder: (context, index) {
            //       final item = items[index];
            //       if (_editMode) {
            //         return EditableShoppingListTile(
            //           key: ValueKey(item.id),
            //           shoppingItem: item,
            //           onEnter: () {},
            //         );
            //       } else {
            //         return ShoppingListTile(
            //             key: ValueKey(item.id), shoppingItem: item);
            //       }
            //     }),
            // if (_editMode)
            //   Center(
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 48.0),
            //       child: ElevatedButton(
            //           onPressed: () {
            //             setState(() {
            //               items.add(ShoppingItem("", false, items.length));
            //             });
            //           },
            //           child: const Text("add")),
            //     ),
            //   ),
          ],
        );
      },
    );
  }

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }
}

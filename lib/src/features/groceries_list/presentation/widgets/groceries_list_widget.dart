import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shopper/src/app_state/shopper_app_state.dart';
import 'package:shopper/src/features/groceries_list/presentation/widgets/editable_shopping_list_tile.dart';
import 'package:shopper/src/features/groceries_list/presentation/widgets/shopping_list_tile.dart';

class GroceriesListWidget extends StatelessWidget {
  const GroceriesListWidget({
    Key? key,
    required bool editMode,
    required this.context,
  }) : _editMode = editMode, super(key: key);

  final bool _editMode;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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

          ],
        );
      },
    );
  }
}
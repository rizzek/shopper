import 'package:shopper/src/domain/entities/groceries_list.dart';
import 'package:shopper/src/model/shopping_item.dart';
import 'package:shopper/src/model/shopping_list.dart';

abstract class ShopperRepository {
  Future<List<GroceriesList>> getAllShoppingLists();

  Future<LocalGroceriesList?> getFirstShoppingList();

  Future<List<LocalGroceriesItem>> getItemsForList({required LocalGroceriesList list});

  Stream<List<LocalGroceriesItem>> watchItemsForList({required LocalGroceriesList list});

  Future<LocalGroceriesList> createShoppingList({required String title});

  Future<void> createShoppingItem({
    required LocalGroceriesItem item,
    required int listId,
    required int position,
  });

  Future<void> updateShoppingItem(
      {required LocalGroceriesItem item, required int listId, required int position});

  Future updateItemPositions({required List<LocalGroceriesItem> items, required int listId});

  Future deleteItem({required LocalGroceriesItem item});

  void close();
}

/*

  Future<int> createShoppingItem(
      ShoppingItem item, int listId, int position) async {
    return into(driftShoppingItems).insert(
      DriftShoppingItemsCompanion(
        label: Value(item.label),
        completed: Value(item.completed),
        listId: Value(listId),
        listPosition: Value(position),
      ),
    );
  }

  Future updateItem(DriftShoppingItem item) {
    return update(driftShoppingItems).replace(item);
  }

  Future updateItems(List<DriftShoppingItem> items) async {
    await batch(
      (batch) => {
        for (var item in items) {batch.update(driftShoppingItems, item)}
      },
    );
  }

  Future deleteItem(DriftShoppingItem item) {
    return delete(driftShoppingItems).delete(item);
  }
 */

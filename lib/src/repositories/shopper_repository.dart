import 'package:shopper/src/model/shopping_item.dart';
import 'package:shopper/src/model/shopping_list.dart';

abstract class ShopperRepository {
  Future<List<ShoppingList>> getAllShoppingLists();

  Future<ShoppingList?> getFirstShoppingList();

  Future<List<ShoppingItem>> getItemsForList({required ShoppingList list});

  Stream<List<ShoppingItem>> watchItemsForList({required ShoppingList list});

  Future<ShoppingList> createShoppingList({required String title});

  Future<void> createShoppingItem({
    required ShoppingItem item,
    required int listId,
    required int position,
  });

  Future<void> updateShoppingItem(
      {required ShoppingItem item, required int listId, required int position});

  Future<void> updateShoppingItems(
      {required ShoppingItem firstItem,
        required int firstPosition,
        required ShoppingItem secondItem,
        required int secondPosition,
        required int listId});

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

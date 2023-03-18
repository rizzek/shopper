import 'package:shopper/src/domain/entities/groceries_item.dart';
import 'package:shopper/src/domain/entities/groceries_list.dart';

abstract class GroceriesRepository {
  Future<List<GroceriesList>> getAllShoppingLists();

  Future<GroceriesList?> getFirstShoppingList();

  Future<List<GroceriesItem>> getItemsForList({required GroceriesList list});

  Stream<List<GroceriesItem>> watchItemsForList({required GroceriesList list});

  Future<GroceriesList> createShoppingList({required String title});

  Future<void> createShoppingItem({
    required GroceriesItem item,
    required int listId,
    required int position,
  });

  Future<void> updateShoppingItem(
      {required GroceriesItem item, required int listId, required int position});

  Future updateItemPositions({required List<GroceriesItem> items, required int listId});

  Future deleteItem({required GroceriesItem item});

  void close();
}


import 'package:shopper/src/features/groceries_list/data/repositories/drift/drift_models.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_item.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_list.dart';
import 'package:shopper/src/features/groceries_list/domain/repositories/groceries_repository.dart';

import 'shared.dart';

class DriftRepository extends GroceriesRepository {
  final _db = openConnection();

  @override
  Future<GroceriesList> createShoppingList({required String title}) async {
    final id = await _db.createShoppingList(title);
    return getShoppingList(id);
  }

  @override
  Future<void> createShoppingItem({
    required GroceriesItem item,
    required int listId,
    required int position,
  }) async {
    await _db.createShoppingItem(item, listId, position);
  }

  @override
  Future<void> updateShoppingItem(
      {required GroceriesItem item,
      required int listId,
      required int position}) async {
    await _db.updateItem(DriftShoppingItem(
        id: item.id!,
        listId: listId,
        listPosition: position,
        label: item.label,
        completed: item.completed));
  }

  @override
  Future updateItemPositions({required List<GroceriesItem> items, required int listId}) async {
    _db.updatePositions(_modelToDriftItems(items, listId));
  }

  @override
  Future<List<GroceriesList>> getAllShoppingLists() {
    // TODO: implement getAllShoppingLists
    throw UnimplementedError();
  }

  @override
  Future<GroceriesList?> getFirstShoppingList() async {
    final listId = (await _db.firstShoppingList)?.id;
    if (listId == null) return null;
    return getShoppingList(listId);
  }

  Future<GroceriesList> getShoppingList(int id) async {
    var driftList = await _db.getList(id);
    final driftItems = await _db.getItemsForList(id);
    return _driftListToModel(driftList, driftItems: driftItems);
  }

  @override
  Future<List<GroceriesItem>> getItemsForList(
      {required GroceriesList list}) async {
    final listId = list.id;
    if (listId != null) {
      return _driftItemsToModel(await _db.getItemsForList(listId));
    }
    throw ArgumentError(
        "The ShoppingList was not yet known to the database, its id was null. Please use createShoppingList() first.");
  }

  @override
  Stream<List<GroceriesItem>> watchItemsForList({required GroceriesList list}) {
    final listId = list.id;
    if (listId != null) {
      return _db
          .watchItemsForList(listId)
          .map((driftItems) => _driftItemsToModel(driftItems));
    }
    throw ArgumentError(
        "The ShoppingList was not yet known to the database, its id was null. Please use createShoppingList() first.");
  }

  @override
  void close() {
    _db.close();
  }

  GroceriesItem _driftItemToModel(DriftShoppingItem driftItem) {
    return GroceriesItem(driftItem.label, driftItem.completed, driftItem.id);
  }

  List<GroceriesItem> _driftItemsToModel(List<DriftShoppingItem> driftItems) {
    return driftItems.map((e) => _driftItemToModel(e)).toList();
  }

  GroceriesList _driftListToModel(DriftShoppingList driftList,
      {List<DriftShoppingItem> driftItems = const []}) {
    var list = GroceriesList(title: driftList.title, id: driftList.id);
    for (final driftItem in driftItems) {
      list.items.add(_driftItemToModel(driftItem));
    }
    return list;
  }

  List<DriftShoppingItem> _modelToDriftItems(List<GroceriesItem> items, int listId) {
    List<DriftShoppingItem> result = [];
    var index = 0;
    for (var item in items) {
      result.add(DriftShoppingItem(id: item.id!, listId: listId, listPosition: index, label: item.label, completed: item.completed));
      index++;
    }
    return result;
  }

  @override
  Future deleteItem({required GroceriesItem item}) async {
    await _db.deleteItem(item.id!);
  }
}

import 'package:shopper/src/model/shopping_item.dart';
import 'package:shopper/src/model/shopping_list.dart';
import 'package:shopper/src/repositories/drift/drift_models.dart';
import 'package:shopper/src/repositories/shopper_repository.dart';

class DriftRepository extends ShopperRepository {
  final _db = DriftShopperDatabase();

  @override
  Future<ShoppingList> createShoppingList({required String title}) async {
    final id = await _db.createShoppingList(title);
    return getShoppingList(id);
  }

  @override
  Future<void> createShoppingItem({
    required ShoppingItem item,
    required int listId,
    required int position,
  }) async {
    await _db.createShoppingItem(item, listId, position);
  }

  @override
  Future<void> updateShoppingItem(
      {required ShoppingItem item,
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
  Future updateItemPositions({required List<ShoppingItem> items, required int listId}) async {
    _db.updatePositions(_modelToDriftItems(items, listId));
  }

  @override
  Future<List<ShoppingList>> getAllShoppingLists() {
    // TODO: implement getAllShoppingLists
    throw UnimplementedError();
  }

  @override
  Future<ShoppingList?> getFirstShoppingList() async {
    final listId = (await _db.firstShoppingList)?.id;
    if (listId == null) return null;
    return getShoppingList(listId);
  }

  Future<ShoppingList> getShoppingList(int id) async {
    var driftList = await _db.getList(id);
    final driftItems = await _db.getItemsForList(id);
    return _driftListToModel(driftList, driftItems: driftItems);
  }

  @override
  Future<List<ShoppingItem>> getItemsForList(
      {required ShoppingList list}) async {
    final listId = list.id;
    if (listId != null) {
      return _driftItemsToModel(await _db.getItemsForList(listId));
    }
    throw ArgumentError(
        "The ShoppingList was not yet known to the database, its id was null. Please use createShoppingList() first.");
  }

  @override
  Stream<List<ShoppingItem>> watchItemsForList({required ShoppingList list}) {
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

  ShoppingItem _driftItemToModel(DriftShoppingItem driftItem) {
    return ShoppingItem(driftItem.label, driftItem.completed, driftItem.id);
  }

  List<ShoppingItem> _driftItemsToModel(List<DriftShoppingItem> driftItems) {
    return driftItems.map((e) => _driftItemToModel(e)).toList();
  }

  ShoppingList _driftListToModel(DriftShoppingList driftList,
      {List<DriftShoppingItem> driftItems = const []}) {
    var list = ShoppingList(title: driftList.title, id: driftList.id);
    for (final driftItem in driftItems) {
      list.items.add(_driftItemToModel(driftItem));
    }
    return list;
  }

  List<DriftShoppingItem> _modelToDriftItems(List<ShoppingItem> items, int listId) {
    List<DriftShoppingItem> result = [];
    var index = 0;
    for (var item in items) {
      result.add(DriftShoppingItem(id: item.id!, listId: listId, listPosition: index, label: item.label, completed: item.completed));
      index++;
    }
    return result;
  }

  @override
  Future deleteItem({required ShoppingItem item}) async {
    await _db.deleteItem(item.id!);
  }
}

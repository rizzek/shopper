import 'dart:async';

import 'package:drift/drift.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_item.dart';

part 'drift_models.g.dart';

// Table for the shopping items
class DriftShoppingItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get listId => integer()();

  IntColumn get listPosition => integer()();

  TextColumn get label => text()();

  BoolColumn get completed => boolean()();
}

// Table for the shopping lists
class DriftShoppingLists extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1)();
}


// drift database
@DriftDatabase(tables: [DriftShoppingLists, DriftShoppingItems])
class DriftShopperDatabase extends _$DriftShopperDatabase {
  DriftShopperDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<List<DriftShoppingList>> get allShoppingLists =>
      select(driftShoppingLists).get();

  Future<DriftShoppingList?> get firstShoppingList =>
      (select(driftShoppingLists)..limit(1))
          .getSingle()
          .then((value) => Future<DriftShoppingList?>.value(value))
          .catchError((e) => null);

  Future<DriftShoppingList> getList(int id) {
    return (select(driftShoppingLists)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<DriftShoppingItem>> getItemsForList(int listId) {
    return (select(driftShoppingItems)
          ..where((tbl) => tbl.listId.equals(listId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.listId)]))
        .get();
  }

  Stream<List<DriftShoppingItem>> watchItemsForList(int listId) {
    return (select(driftShoppingItems)
          ..where((tbl) => tbl.listId.equals(listId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.listPosition)]))
        .watch();
  }

  Future<int> createShoppingList(String title) async {
    return into(driftShoppingLists)
        .insert(DriftShoppingListsCompanion(title: Value(title)));
  }

  Future<int> createShoppingItem(
      GroceriesItem item, int listId, int position) async {
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
    return transaction(() async {
      for (var item in items) {
        await (update(driftShoppingItems)
              ..where((tbl) => tbl.id.equals(item.id)))
            .write(item);
      }
    });
  }

  Future updatePositions(List<DriftShoppingItem> items) async {
    return transaction(() async {
      for (var item in items) {
        await (update(driftShoppingItems)
          ..where((tbl) => tbl.id.equals(item.id)))
            .write(DriftShoppingItemsCompanion(listPosition: Value(item.listPosition)));
      }
    });
  }

  Future deleteItem(int itemId) async {
    return (delete(driftShoppingItems)..where((tbl) => tbl.id.equals(itemId))).go();
  }
}

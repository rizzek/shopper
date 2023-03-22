import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopper/src/app_state/remote_credential_store.dart';
import 'package:shopper/src/features/groceries_list/data/repositories/drift/drift_repository.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_item.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_list.dart';
import 'package:shopper/src/features/groceries_list/domain/repositories/groceries_repository.dart';

class ShopperAppState extends ChangeNotifier {
  final GroceriesRepository _shopperRepository = DriftRepository();

  final RemoteCredentialStore _remoteCredentialStore = RemoteCredentialStore();

  late GroceriesList _list;

  List<GroceriesItem> listItems = [];

  Stream<List<GroceriesItem>>? _listItems;

  StreamSubscription<List<GroceriesItem>>? _listItemsSubscription;

  Future<void> init() async {
    final list = await _shopperRepository.getFirstShoppingList();
    if (list == null) {
      _list =
          await _shopperRepository.createShoppingList(title: "Default List");
    } else {
      _list = list;
    }
    _listItems = _shopperRepository.watchItemsForList(list: _list);
    _listItemsSubscription = _listItems?.listen((newItemList) {
      print("Got new state from drift: $newItemList");
      listItems = newItemList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listItemsSubscription?.cancel();
    _shopperRepository.close();
  }

  void addItem({int? position}) {
    _shopperRepository.createShoppingItem(item: GroceriesItem('', false, null), listId: _list.id, position: position ?? listItems.length);
  }

  void updateItem(GroceriesItem item, {int? position}) {
    _shopperRepository.updateShoppingItem(item: item, listId: _list.id, position: position ?? listItems.indexWhere((listItem) => listItem.id == item.id));
  }

  void updateItemPositions(List<GroceriesItem> items) {
    _shopperRepository.updateItemPositions(items: items, listId: _list.id);
  }

  void deleteItem(GroceriesItem item) async {
    await _shopperRepository.deleteItem(item: item);
    updateItemPositions(listItems);
  }

  Future<StorageSettings> getSyncSettings() {
    return _remoteCredentialStore.getSettings();
  }

  Future saveSyncSettings(RemoteStore store, String url, String basePath, String username, String password) {
    return _remoteCredentialStore.storeSettings(store, url, username, password);
  }

}

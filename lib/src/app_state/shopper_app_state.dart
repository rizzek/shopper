import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopper/src/model/shopping_item.dart';
import 'package:shopper/src/model/shopping_list.dart';
import 'package:shopper/src/repositories/drift/drift_repository.dart';
import 'package:shopper/src/repositories/shopper_repository.dart';

class ShopperAppState extends ChangeNotifier {
  final ShopperRepository _shopperRepository = DriftRepository();

  late ShoppingList _list;

  List<ShoppingItem> listItems = [];

  Stream<List<ShoppingItem>>? _listItems;

  StreamSubscription<List<ShoppingItem>>? _listItemsSubscription;

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
    _shopperRepository.createShoppingItem(item: ShoppingItem('', false, null), listId: _list.id!, position: position ?? listItems.length);
  }

  void updateItem(ShoppingItem item, {int? position}) {
    _shopperRepository.updateShoppingItem(item: item, listId: _list.id!, position: position ?? listItems.indexWhere((listItem) => listItem.id == item.id));
  }

  void updateItemPositions(List<ShoppingItem> items) {
    _shopperRepository.updateItemPositions(items: items, listId: _list.id!);
  }

  void deleteItem(ShoppingItem item) async {
    await _shopperRepository.deleteItem(item: item);
    updateItemPositions(listItems);
  }
}

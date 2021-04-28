import 'package:flutter/material.dart';
import 'package:shopper/model/list_entry.dart';

class ItemList extends StatefulWidget {

  ItemList(this.entries) : super();

  final List<ListEntry> entries;

  @override
  _ItemListState createState() => _ItemListState(entries: entries);
}

class _ItemListState extends State<ItemList> {

  _ItemListState({this.entries});

  List<ListEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final item = entries[index];
          return CheckboxListTile(value: item.checked, title: Text(item.name), onChanged: (value) => {
            setState(() {
              entries[index].checked = value;
          })
          },);
    });

  }
}

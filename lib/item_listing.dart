import 'package:adaptive_master_detail_layouts/item.dart';
import 'package:adaptive_master_detail_layouts/item_details.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemListing extends StatelessWidget {
  ItemListing({
    @required this.itemSelectedCallback,
    this.selectedItem,
  });

  final ValueChanged<Item> itemSelectedCallback;
  final Item selectedItem;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: items.map((item) {
        return new ListTile(
          title: new Text(item.title),
          onTap: () => itemSelectedCallback(item),
          selected: selectedItem == item,
        );
      }).toList(),
    );
  }
}

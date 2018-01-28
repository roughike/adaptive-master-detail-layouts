import 'package:adaptive_master_detail_layouts/item.dart';
import 'package:adaptive_master_detail_layouts/item_details.dart';
import 'package:flutter/material.dart';

class ItemListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Master-detail flow sample'),
      ),
      body: new ListView(
        children: items.map((item) {
          return new ListTile(
            title: new Text(item.title),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (_) => new ItemDetails(item: item),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

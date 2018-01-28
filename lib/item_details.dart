import 'package:adaptive_master_detail_layouts/item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({@required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text(
          item.title,
          style: textTheme.headline,
        ),
        new Text(
          item.subtitle,
          style: textTheme.subhead,
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(item.title),
      ),
      body: new Center(child: content),
    );
  }
}

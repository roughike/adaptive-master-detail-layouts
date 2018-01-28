import 'dart:math';

import 'package:adaptive_master_detail_layouts/item.dart';
import 'package:adaptive_master_detail_layouts/item_details.dart';
import 'package:adaptive_master_detail_layouts/item_listing.dart';
import 'package:flutter/material.dart';

class MasterDetailContainer extends StatefulWidget {
  @override
  _ItemMasterDetailContainerState createState() =>
      new _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  Item _selectedItem;

  Widget _buildMobileLayout() {
    return new ItemListing(
      itemSelectedCallback: (item) {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) {
              return new ItemDetails(
                isInTabletLayout: false,
                item: item,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return new Row(
      children: <Widget>[
        new Flexible(
          flex: 1,
          child: new Material(
            elevation: 4.0,
            child: new ItemListing(
              itemSelectedCallback: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
              selectedItem: _selectedItem,
            ),
          ),
        ),
        new Flexible(
          flex: 3,
          child: new ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Master-detail flow sample'),
      ),
      body: new LayoutBuilder(
        builder: (context, constraints) {
          final double smallestDimension = min(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          if (smallestDimension < kTabletBreakpoint) {
            return _buildMobileLayout();
          }

          return _buildTabletLayout();
        },
      ),
    );
  }
}
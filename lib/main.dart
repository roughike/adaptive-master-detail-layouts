import 'package:adaptive_master_detail_layouts/master_detail_container.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Master-Detail example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MasterDetailContainer(),
    );
  }
}
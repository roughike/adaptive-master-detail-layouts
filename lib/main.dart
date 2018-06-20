import 'package:adaptive_master_detail_layouts/master_detail_container.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master-Detail example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterDetailContainer(),
    );
  }
}
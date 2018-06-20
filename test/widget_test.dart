import 'package:adaptive_master_detail_layouts/item_details.dart';
import 'package:adaptive_master_detail_layouts/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    await tester.tap(find.byType(ListTile).first);

    await tester.pump();
    await tester.pump();
    expect(find.byType(ItemDetails), findsOneWidget);
  });
}

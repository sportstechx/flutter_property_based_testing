import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:warehouse_prop_testing/my_app.dart';

void main() {
  testWidgets('When app displayed then UI is drawn', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text("Product Inventory"), findsOneWidget);
  });
}

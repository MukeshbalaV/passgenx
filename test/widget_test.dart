// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passgenx/main.dart';

void main() {
  testWidgets('Toggle dark mode test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that dark mode is initially off.
    expect(Theme.of(tester.element(find.text('Toggle Dark Mode'))).brightness, equals(Brightness.light));

    // Tap the dark mode toggle and trigger a frame.
    await tester.tap(find.byIcon(Icons.brightness_4));
    await tester.pump();

    // Verify that dark mode is now on.
    expect(Theme.of(tester.element(find.text('Toggle Dark Mode'))).brightness, equals(Brightness.dark));
  });
}


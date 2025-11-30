import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/create_community_page.dart';
import 'package:flutter_web_app/mock_data.dart';

void main() {
  testWidgets('Create Community Page functionality',
      (WidgetTester tester) async {
    // Pump the widget
    await tester.pumpWidget(const MaterialApp(
      home: CreateCommunityPage(),
    ));

    // Verify initial state
    expect(find.widgetWithText(AppBar, 'Create Community'), findsOneWidget);
    expect(find.text('Community Name'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);

    // Enter text
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Community Name'), 'New Community');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'), 'A description');

    // Tap create button
    await tester.tap(find.widgetWithText(FilledButton, 'Create Community'));
    await tester.pumpAndSettle();

    // Verify community was added to MockData
    final newCommunity = MockData.communities.last;
    expect(newCommunity.name, 'New Community');
    expect(newCommunity.description, 'A description');
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_web_app/main.dart';

void main() {
  testWidgets('Verify AppBar and Drawer items and Navigation',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title
    expect(find.text('UniCosCom'), findsOneWidget);

    // Verify Login button
    expect(find.text('Log in'), findsOneWidget);

    // Verify Menu button (icon)
    expect(find.byIcon(Icons.menu), findsOneWidget);

    // Open the drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify Drawer items
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Create Community'), findsOneWidget);
    expect(find.text('Create Post'), findsOneWidget);

    // Test Navigation to Settings
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Dark Mode'), findsOneWidget);

    // Go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Open drawer again
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Test Navigation to Create Community
    await tester.tap(find.text('Create Community'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Create Community'), findsOneWidget);

    // Go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Open drawer again
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Test Navigation to Create Post
    await tester.tap(find.text('Create Post'));
    await tester.pumpAndSettle();
    expect(find.text('Create Post'), findsOneWidget);

    // Fill out the form
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'), 'My New Post');
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('FlutterDev').last); // Select FlutterDev
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Content'),
        'This is the content of my new post.');

    // Submit
    await tester.tap(find.text('Post'));
    await tester.pumpAndSettle();

    // Verify we are back at Home
    expect(find.text('UniCosCom'), findsOneWidget);
  });
}

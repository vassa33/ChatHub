import 'package:chathub/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chathub/service/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Ensure AuthService is a class or mixin
class AuthService {}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

// Mock DatabaseService
class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('HomePage Widget Tests', () {
    // Mock services and necessary dependencies
    setUp(() {});

    testWidgets('Test AppBar and Drawer Widgets', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      // Verify the existence of key widgets in AppBar and Drawer
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Groups'), findsOneWidget);
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('Test FloatingActionButton', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      // Verify the existence of FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Test Drawer Menu Items', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      // Open the drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify the existence of key items in the Drawer menu
      expect(find.text('Groups'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });
  });
}

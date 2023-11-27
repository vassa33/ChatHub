import 'package:chathub/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Ensure AuthService is a class or mixin
class AuthService {}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  group('ProfilePage Widget Tests', () {
    // Mock services and necessary dependencies

    setUp(() {});

    testWidgets('Test AppBar and Drawer Widgets', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfilePage(
            userName: 'TestUser',
            email: 'test@example.com',
          ),
        ),
      );

      // Verify the existence of key widgets in AppBar and Drawer
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Groups'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('Test Body Widgets', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfilePage(
            userName: 'TestUser',
            email: 'test@example.com',
          ),
        ),
      );

      // Verify the existence of key widgets in the body
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byIcon(Icons.account_circle), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('TestUser'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('Test Drawer Menu Items', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfilePage(
            userName: 'TestUser',
            email: 'test@example.com',
          ),
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

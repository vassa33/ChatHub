import 'package:chathub/pages/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Ensure AuthService is a class or mixin
class AuthService {}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {
  Future<void> registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    return Future.value();
  }
}

void main() {
  group('RegisterPage Widget Tests', () {
    // Mock services and necessary dependencies
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    testWidgets('Test UI Widgets', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage(),
        ),
      );

      // Verify the existence of key widgets in the UI
      expect(find.text('Groupie'), findsOneWidget);
      expect(find.text("Create your account now to chat and explore"),
          findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text("Register"), findsOneWidget);
      expect(find.text("Already have an account? Login now"), findsOneWidget);
    });

    testWidgets('Test Registration Process', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage(),
        ),
      );

      // Enter text into text fields
      await tester.enterText(
          find.byKey(const Key('fullNameField')), 'John Doe');
      await tester.enterText(
          find.byKey(const Key('emailField')), 'john.doe@example.com');
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'password123');

      // Tap the Register button
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pumpAndSettle();

      // Verify the behavior after tapping the Register button
      verify(mockAuthService.registerUserWithEmailandPassword(
              'John Doe', 'john.doe@example.com', 'password123'))
          .called(1);
    });
  });
}

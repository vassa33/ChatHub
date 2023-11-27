import 'package:chathub/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Ensure AuthService is a class or mixin
class AuthService {}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {
  Future<void> googleSignInMethod() async {
    return Future.value();
  }
}

void main() {
  group('LoginPage Widget Tests', () {
    // Mock services and necessary dependencies
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    testWidgets('Test UI Widgets', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      // Verify the existence of key widgets in the UI
      expect(find.text('Groupie'), findsOneWidget);
      expect(
          find.text("Login now to see what they are talking!"), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.text("Sign In"), findsOneWidget);
      expect(find.text("Sign in with Google"), findsOneWidget);
      expect(find.text("Don't have an account? Register here"), findsOneWidget);
    });

    testWidgets('Test Google Sign-In Button', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      // Tap the Google Sign-In button
      await tester.tap(find.byKey(const Key('googleSignInButton')));
      await tester.pumpAndSettle();

      // Verify the behavior after tapping the button
      verify(mockAuthService.googleSignInMethod()).called(1);
    });
  });
}

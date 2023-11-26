import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chathub/pages/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize Firebase before running tests
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  testWidgets('Login Page Widgets Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verify that the widgets are rendered on the screen.

    // Test 1: Email Input Field
    expect(find.byKey(const Key('email_input')), findsOneWidget);
    await tester.enterText(
        find.byKey(const Key('email_input')), 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Test 2: Password Input Field
    expect(find.byKey(const Key('password_input')), findsOneWidget);
    await tester.enterText(
        find.byKey(const Key('password_input')), 'password123');
    expect(find.text('password123'), findsOneWidget);

    // Test 3: Google Sign-In Button
    expect(find.byKey(const Key('google_sign_in_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('google_sign_in_button')));
    await tester.pump();

    // You can add more widget tests as needed.

    // Example: Test 4 - Elevated Sign-In Button
    expect(find.text('Sign In'), findsOneWidget);
    await tester.tap(find.text('Sign In'));
    await tester.pump();
  });
}

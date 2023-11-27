import 'package:chathub/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:chathub/service/database_service.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock DatabaseService class
class MockDatabaseService extends Mock implements DatabaseService {}

// MockFirebaseApp class
class MockFirebaseApp extends Mock implements firebase_core.FirebaseApp {
  MockFirebaseApp() : super();
}

void main() {
  late MockDatabaseService mockDatabaseService;

  setUp(() async {
    await firebase_core.Firebase.initializeApp();
    mockDatabaseService = MockDatabaseService();
  });

  testWidgets('chat page test', (tester) async {
    // Mock Firebase.initializeApp
    when(firebase_core.Firebase.initializeApp())
        .thenAnswer((_) async => Future.value(MockFirebaseApp()));

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: ChatPage(
          groupId: "mockGroupId",
          groupName: "MockGroup",
          userName: "MockUser",
        ),
      ),
    );

    // Trigger the send message function
    await tester.tap(find.byIcon(Icons.send));

    // Verify that sendMessage method is called
    verify(mockDatabaseService
        .sendMessage("mockGroupId", {'mockKey': 'mockValue'})).called(1);

    // Verify the captured arguments for getChats
    final capturedArguments = <String>[]; // Declare the list
    verify(mockDatabaseService.getChats('mockString'))
        .captured
        .single
        .then((arguments) {
      capturedArguments.addAll(arguments);
    });
    verify(mockDatabaseService.getChats('mockString')).called(1);

    // Print the captured arguments for debugging
    debugPrint('Captured arguments for getChats: ${capturedArguments.first}');
  });
}

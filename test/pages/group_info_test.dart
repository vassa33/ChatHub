import 'package:chathub/pages/group_info.dart';
import 'package:chathub/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock DatabaseService class
class MockDatabaseService extends Mock implements DatabaseService {}

// MockFirebaseApp class
class MockFirebaseApp extends Mock implements FirebaseApp {}

// MockFirebaseUser class
class MockFirebaseUser extends Mock implements User {
  @override
  String get uid => 'mockUserId';
}

// Mock FirebaseAuth class
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User get currentUser => MockFirebaseUser();
}

void main() {
  testWidgets('group info test', (tester) async {
    // Mock Firebase.initializeApp
    when(Firebase.initializeApp())
        .thenAnswer((_) async => Future.value(MockFirebaseApp()));

    // Mock FirebaseAuth
    when(MockFirebaseAuth().currentUser).thenReturn(MockFirebaseUser());

    // Create a mock DatabaseService
    final mockDatabaseService = MockDatabaseService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: GroupInfo(
          groupId: "mockGroupId",
          groupName: "MockGroup",
          adminName: "MockAdmin",
        ),
      ),
    );

    // Verify that getMembers method is called
    verify(mockDatabaseService.getGroupMembers('mockGroupId')).called(1);
  });
}

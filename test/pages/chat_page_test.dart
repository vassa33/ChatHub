import 'package:chathub/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chathub/pages/chat_page.dart';

void main() {
  testWidgets('Chat Page Widgets Test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: ChatPage(
          groupId: 'groupId',
          groupName: 'groupName',
          userName: 'userName',
        ),
      ),
    );

    // Test for the presence of the app bar title.
    expect(find.text('groupName'), findsOneWidget);

    // Test for the presence of the input text field.
    expect(find.byType(TextFormField), findsOneWidget);

    // Test for the presence of the send button.
    expect(find.byIcon(Icons.send), findsOneWidget);

    // Test for the absence of messages initially.
    expect(find.byType(MessageTile), findsNothing);

    // Now, let's test some methods.

    // Mock a message and send it.
    await tester.enterText(find.byType(TextFormField), 'Test message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Test if the message is visible after sending.
    expect(find.text('Test message'), findsOneWidget);
  });
}

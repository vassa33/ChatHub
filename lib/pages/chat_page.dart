// Importing necessary libraries and widgets.
import 'package:chathub/pages/group_info.dart';
import 'package:chathub/service/database_service.dart';
import 'package:chathub/widgets/message_tile.dart';
import 'package:chathub/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Represents the chat page of the app where users can communicate within a group.
/// [groupId] is the unique identifier of the group.
/// [groupName] is the name of the group.
/// [userName] is the name of the currently logged-in user.
class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // A stream to keep track of chat messages.
  Stream<QuerySnapshot>? chats;
  // Controller for the text field where users type their messages.
  TextEditingController messageController = TextEditingController();
  // The admin of the group.
  String admin = "";

  @override
  void initState() {
    super.initState();
    getChatandAdmin(); // Fetch the chat messages and the group's admin.
  }

  /// Fetches the chat messages and the group's admin information.
  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });

    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // An icon button that navigates to the group information page.
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                GroupInfo(
                  groupId: widget.groupId,
                  groupName: widget.groupName,
                  adminName: admin,
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Displaying the chat messages.
          chatMessages(),
          // The text field and send button to type and send messages.
          inputMessageField(context),
        ],
      ),
    );
  }

  /// Returns a widget that displays the chat messages.
  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index]['message'],
                    sender: snapshot.data.docs[index]['sender'],
                    sentByMe:
                        widget.userName == snapshot.data.docs[index]['sender'],
                  );
                },
              )
            : Container();
      },
    );
  }

  /// Returns a widget containing a text field to input messages and a send button.
  Widget inputMessageField(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        color: Colors.grey[700],
        child: Row(children: [
          // Text field to input messages.
          Expanded(
            child: TextFormField(
              controller: messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Send a message...",
                hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Send button.
          GestureDetector(
            onTap: () {
              sendMessage();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Sends a chat message to the Firestore database.
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      // Constructing the message object to send.
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear(); // Clear the input field after sending.
      });
    }
  }
}

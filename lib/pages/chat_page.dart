import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/components/my_textfield.dart';
import 'package:my_chatt_app/services/auth/auth_services.dart';
import 'package:my_chatt_app/services/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key, 
    required this.receiverEmail, 
    required this.receiverID
    });
    
  //text controller
  final TextEditingController _messageContoller = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //sendMessage
  void sendMessage() async {
    //if there something inside the textfield
    if (_messageContoller.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageContoller.text);

      //clear text controller
      _messageContoller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList(),
          ),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build mesage list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Text(data["message"]);
  }

  //build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        //textfield should take up most the space
        Expanded(
          child: MyTextfield(
            controller: _messageContoller,
            hintText: "Type a message",
            obsecureText: false,
          ),
        ),

        //send button
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
      ],
    );
  }
}

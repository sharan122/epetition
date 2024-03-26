import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mass_petition_app/Loginpage.dart';
import 'package:mass_petition_app/Models/SentMessageModel.dart';
import 'package:mass_petition_app/Models/ViewChatModel.dart';
import 'package:mass_petition_app/homepage/post_details.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _user1ScrollController = ScrollController();
  ScrollController _user2ScrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _user1ScrollController.dispose();
    _user2ScrollController.dispose();
    super.dispose();
  }

  Future<SentChat> sentMessage() async {
    const String apiurl = "http://54.89.172.156/sendMessege";
    try {
      final response = await http.post(
        Uri.parse(apiurl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "ChatId": chatId,
          "fkUserLoginId": userLoginId,
          "message": _messageController.text
        }),
      );
      var data = response.body;
      print(data);
      if (response.statusCode == 200) {
        return SentChat.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        print("HTTP error: ${response.statusCode}");
        throw Exception("failed to send message");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception("failed to send message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          // For example, you can fetch new messages from the server
          await _fetchMessages();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _user1ScrollController,
                reverse: false, // Scroll to bottom by default
                itemCount: Provider.of<UserMessagesProvider>(context)
                    .user1Messages
                    .length,
                itemBuilder: (context, index) {
                  return _buildMessage(
                    Provider.of<UserMessagesProvider>(context)
                        .user1Messages[index],
                    userLoginId!,
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _user2ScrollController,
                reverse: false, // Scroll to bottom by default
                itemCount: Provider.of<UserMessagesProvider>(context)
                    .user2Messages
                    .length,
                itemBuilder: (context, index) {
                  return _buildMessage(
                    Provider.of<UserMessagesProvider>(context)
                        .user2Messages[index],
                    userLoginId!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // Send the message here
                String message = _messageController.text;
                if (message.isNotEmpty) {
                  sentMessage();
                  _messageController.clear();
                  // Scroll to bottom after sending message
                  _user1ScrollController.animateTo(
                    _user1ScrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                  _user2ScrollController.animateTo(
                    _user2ScrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message, String userLoginId) {
    return Align(
      alignment: message.fkUserLoginId == userLoginId
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          left: message.fkUserLoginId == userLoginId ? 10 : 0,
          right: message.fkUserLoginId == userLoginId ? 0 : 10,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.fkUserLoginId == userLoginId
              ? Colors.grey[300]
              : Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.message!,
          style: TextStyle(
            color: message.fkUserLoginId == userLoginId
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _fetchMessages() async {
    fetchChat(context);
    // Implement your logic to fetch messages from the server here
    // For example, you can make an HTTP request to fetch new messages
    // After fetching messages, update the UI accordingly
    // This function will be called when the user pulls down to refresh
  }
}

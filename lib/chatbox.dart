
// screen chat box chat with AI
import 'package:ai_chat_mobile_app/message.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

// State of chat box
class _ChatBoxState extends State<ChatBox> {
  // List of messages
  List<Message> messages = [];

  // Text controller for input
  TextEditingController textController = TextEditingController();

  // Scroll controller for list view
  ScrollController scrollController = ScrollController();

  // Send message
  void sendMessage() {
    // Get text from input
    String text = textController.text;

    // Clear input
    textController.clear();

    // Add message to list
    setState(() {
      messages.add(Message(text: text));
    });

    // Scroll to bottom
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Send message to AI
  }

  messageBubble(Message message){
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(message.text),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // screen chatbox
    return Scaffold(
      // App bar
      appBar: AppBar(
        // Title
        title: const Text('Chat with AI'),
      ),
      // Body
      body: Column(
        // Children
        children: [
          // Expanded list view
          Expanded(
            // List view
            child: ListView.builder(
              // Reverse
              reverse: true,
              // Controller
              controller: scrollController,
              // Item count
              itemCount: messages.length,
              // Item builder
              itemBuilder: (context, index) {
                // Message
                Message message = messages[index];

                // Return message bubble
                return messageBubble(message);
              },
            ),
          ),
          // Input
          Padding(
            // Padding
            padding: const EdgeInsets.all(8.0),
            // Text field
            child: TextField(
              // Controller
              controller: textController,
              // On submitted
              onSubmitted: (text) {
                // Send message
                sendMessage();
              },
              // Decoration
              decoration: InputDecoration(
                // Border
                border: OutlineInputBorder(),
                // Label
                labelText: 'Message',
              ),
            ),
          ),
        ],
      ),
      // Floating action button
      floatingActionButton: FloatingActionButton(
        // Icon
        child: const Icon(Icons.send),
        // On pressed
        onPressed: () {
          // Send message
          sendMessage();
        },
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_appbar.dart';
import 'package:kowri/widgets/custom_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;


Future<void> _sendMessage() async {
  final input = _controller.text.trim();
  if (input.isEmpty) return;

  setState(() {
    _messages.add({'role': 'user', 'content': input});
    _isLoading = true;
    _controller.clear();
  });

  try {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "your-api-here", 
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          ..._messages.map((m) => {
            'role': m['role'],
            'content': m['content'],
          }),
        ],
      }),
    );

    print("API RESPONSE STATUS: ${response.statusCode}");
    print("API RESPONSE BODY: ${response.body}");

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 && decoded['choices'] != null && decoded['choices'].isNotEmpty) {
      final aiMessage = decoded['choices'][0]['message']['content'];

      setState(() {
        _messages.add({'role': 'assistant', 'content': aiMessage.trim()});
      });
    } else {
      // If the API returned an error, show it in chat
      final errorMessage = decoded['error']?['message'] ?? 'Unknown error occurred.';
      setState(() {
        _messages.add({
          'role': 'assistant',
          'content': "⚠️ OpenAI Error: To demonstrate this part of the AI, you'll need to provide me with a ChatGPT API secret key. Also, you have to enable that billing for me to show this part.",
        });
      });
    }
  } catch (e) {
    // Catch network or parsing errors
    setState(() {
      _messages.add({
        'role': 'assistant',
        'content': '⚠️ Failed to connect to AI: $e',
      });
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message['content'] ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        leading: CustomBackButton(
          onTap: () {
            context.pop();
          },
        ),
        title: const CustomText(
          text: "AI Assistant",
          size: h2,
          color: background,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push("/settings");
            },
            icon: const FaIcon(
              FontAwesomeIcons.cogs,
              size: 20,
              color: background,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: primary,
                    size: 35
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

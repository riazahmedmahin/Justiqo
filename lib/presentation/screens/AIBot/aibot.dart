import 'package:flutter/material.dart';

class AiBot extends StatefulWidget {
  @override
  _AiBotState createState() => _AiBotState();
}

class _AiBotState extends State<AiBot> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    String input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': input});
    });

    _controller.clear();
    _getBotResponse(input);
  }

  void _getBotResponse(String userMessage) {
    String botReply = _generateReply(userMessage);

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _messages.add({'sender': 'bot', 'text': botReply});
      });
    });
  }

  String _generateReply(String message) {
    message = message.toLowerCase();

    if (message.contains('divorce')) {
      return '''For filing a divorce, you generally need:
1. Marriage registration certificate
2. National ID or valid identification
3. A written notice stating the reason for divorce
4. Court approval (in some cases)''';
    } else if (message.contains('fir')) {
      return '''To file an FIR (First Information Report):
1. Detailed description of the incident
2. Time and location
3. Name of the accused (if known)
4. Submit it at your nearest police station''';
    } else if (message.contains('job') || message.contains('termination')) {
      return '''If you're terminated from a job:
- You may be entitled to one month's notice or salary in lieu
- You should receive your due salary and bonus
- You can file a complaint in the Labor Court if needed''';
    } else if (message.contains('land registration')) {
      return '''Documents needed for land registration:
1. Title deed or ownership papers
2. Mouza map
3. Khatiyan (record of rights)
4. Proper stamps and fees
5. Submit to the local sub-registrar office''';
    } else if (message.contains('marriage registration')) {
      return '''For marriage registration:
1. NID or valid ID of both bride and groom
2. Two witnesses
3. Completed marriage form
4. Register at an authorized registrar office''';
    } else if (message.contains('bail')) {
      return '''To apply for bail:
- Submit a bail petition through your lawyer
- Be present for the bail hearing
- Bail is more difficult in non-bailable offenses, but possible''';
    } else if (message.contains('hello') || message.contains('hi')) {
      return "Hello! I’m LawBot, your virtual legal assistant. Ask me any legal question!";
    } else if (message.contains('your name')) {
      return "I'm LawBot — your AI-powered legal assistant.";
    } else {
      return "I'm not sure how to answer that yet. Please try rephrasing your question or ask something else related to legal help.";
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isUser ? Colors.indigo[100] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(16),
              bottomLeft: isUser ? Radius.circular(16) : Radius.circular(0),
              bottomRight: isUser ? Radius.circular(0) : Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: Text(
            message['text'] ?? '',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F0FE),
      appBar: AppBar(
        title: Text('LawBot - Legal Assistant'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      //color: Color(0xFFF1F3F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask your legal question...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Chat Detail Screen
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';
import 'package:layer/data/model/model.dart';
import 'package:layer/main.dart';

class ChatDetailScreen extends StatefulWidget {
  final Lawyer lawyer;

  const ChatDetailScreen({
    Key? key,
    required this.lawyer,
  }) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Mock data for chats
  late List<ChatMessage> _messages;
  bool _isRecording = false;
  bool _isAttaching = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize mock messages
    _messages = [
      ChatMessage(
        senderId: 'lawyer',
        text: 'Hello! How can I help you with your legal matter today?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
      ChatMessage(
        senderId: 'user',
        text: 'Hi, I need advice on a contract I received.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      ),
      ChatMessage(
        senderId: 'lawyer',
        text: 'I\'d be happy to help. Could you provide more details about the contract?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      ChatMessage(
        senderId: 'user',
        text: 'It\'s an employment contract. I\'m concerned about the non-compete clause.',
        timestamp: DateTime.now().subtract(const Duration(hours: 23)),
      ),
      ChatMessage(
        senderId: 'lawyer',
        text: 'Non-compete clauses can be tricky. Could you share the specific language you\'re concerned about?',
        timestamp: DateTime.now().subtract(const Duration(hours: 22)),
      ),
    ];
    
    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    setState(() {
      _messages.add(
        ChatMessage(
          senderId: 'user',
          text: text,
          timestamp: DateTime.now(),
        ),
      );
      
      // Simulate lawyer response after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _messages.add(
              ChatMessage(
                senderId: 'lawyer',
                text: 'Thank you for your message. I\'ll review this and get back to you shortly.',
                timestamp: DateTime.now(),
              ),
            );
          });
          _scrollToBottom();
        }
      });
    });
    
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.lawyer.photoUrl),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lawyer.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[100],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Video call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Audio call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                image: DecorationImage(
                  image: const AssetImage('assets/chat_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message.senderId == 'user';
                  
                  // Check if we need to show date header
                  bool showDateHeader = false;
                  if (index == 0) {
                    showDateHeader = true;
                  } else {
                    final prevMessage = _messages[index - 1];
                    final prevDate = DateTime(
                      prevMessage.timestamp.year,
                      prevMessage.timestamp.month,
                      prevMessage.timestamp.day,
                    );
                    final currentDate = DateTime(
                      message.timestamp.year,
                      message.timestamp.month,
                      message.timestamp.day,
                    );
                    
                    if (prevDate != currentDate) {
                      showDateHeader = true;
                    }
                  }
                  
                  return Column(
                    children: [
                      if (showDateHeader)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            _formatDateHeader(message.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: ChatBubble(
                            clipper: isUser
                                ? ChatBubbleClipper5(type: BubbleType.sendBubble)
                                : ChatBubbleClipper5(type: BubbleType.receiverBubble),
                            alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 8),
                            backGroundColor: isUser
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    message.text,
                                    style: TextStyle(
                                      color: isUser ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat('h:mm a').format(message.timestamp),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isUser ? Colors.white70 : Colors.grey[600],
                                        ),
                                      ),
                                      if (isUser) ...[
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.done_all,
                                          size: 14,
                                          color: index == _messages.length - 1 ? Colors.white70 : Colors.blue[100],
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          
          // Attachment options
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isAttaching ? 160 : 0,
            color: Colors.grey[200],
            child: _isAttaching
                ? GridView.count(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildAttachmentOption(Icons.photo, 'Photos', Colors.purple),
                      _buildAttachmentOption(Icons.camera_alt, 'Camera', Colors.red),
                      _buildAttachmentOption(Icons.insert_drive_file, 'Document', Colors.blue),
                      _buildAttachmentOption(Icons.location_on, 'Location', Colors.green),
                      _buildAttachmentOption(Icons.person, 'Contact', Colors.orange),
                      _buildAttachmentOption(Icons.music_note, 'Audio', Colors.pink),
                      _buildAttachmentOption(Icons.payment, 'Payment', Colors.teal),
                      _buildAttachmentOption(Icons.poll, 'Poll', Colors.amber),
                    ],
                  )
                : null,
          ),
          
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isAttaching ? Icons.close : Icons.attach_file,
                    color: _isAttaching ? Colors.red : Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _isAttaching = !_isAttaching;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.grey[600],
                        onPressed: () {
                          // Camera functionality
                        },
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onLongPress: () {
                    // Start voice recording
                    setState(() {
                      _isRecording = true;
                    });
                  },
                  onLongPressEnd: (_) {
                    // End voice recording
                    setState(() {
                      _isRecording = false;
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice message sent'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _messageController.text.isEmpty
                          ? _isRecording ? Icons.mic_none : Icons.mic
                          : Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAttachmentOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  String _formatDateHeader(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM dd, yyyy').format(timestamp);
    }
  }
}

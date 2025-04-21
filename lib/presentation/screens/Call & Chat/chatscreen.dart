// Chat Section
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';
import 'package:layer/data/model/model.dart';
import 'package:layer/main.dart';
import 'package:layer/presentation/screens/Call%20&%20Chat/chatDetails.dart';
import 'package:provider/provider.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({Key? key}) : super(key: key);

  @override
  _ChatSectionState createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final lawyerProvider = Provider.of<LawyerProvider>(context);
    final user = authProvider.currentUser;
    final lawyers = lawyerProvider.lawyers;

    if (user == null) {
      return const Center(child: Text('Please login to view messages'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lawyers.length,
        itemBuilder: (context, index) {
          final lawyer = lawyers[index];
          
          // Mock last message
          final lastMessage = index % 3 == 0
              ? 'Thank you for your message. I\'ll review this and get back to you shortly.'
              : index % 3 == 1
                  ? 'Yes, I can help you with that legal matter.'
                  : 'When would be a good time to schedule a consultation?';
          
          // Mock time
          final messageTime = DateTime.now().subtract(Duration(minutes: index * 30));
          
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(lawyer.photoUrl),
                ),
                if (index % 2 == 0)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              lawyer.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                if (index % 3 == 0)
                  const Icon(
                    Icons.done_all,
                    size: 16,
                    color: Colors.blue,
                  ),
                Expanded(
                  child: Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('h:mm a').format(messageTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                if (index % 4 == 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(lawyer: lawyer),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

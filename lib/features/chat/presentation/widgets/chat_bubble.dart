import 'package:flutter/material.dart';
import '../../data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? Colors.green[400] : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.sender,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor.withOpacity(0.8)),
            ),
            const SizedBox(height: 4),
            Text(
              message.message,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 2),
            Text(
              message.timestamp.toLocal().toIso8601String().substring(11, 16),
              style: TextStyle(fontSize: 10, color: textColor.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}

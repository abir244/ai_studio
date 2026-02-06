// lib/features/chat/data/models/message_model.dart
class MessageModel {
  final String? id;
  final String conversationId;
  final String senderId;     // Matches backend
  final String senderName;   // Matches backend
  final String message;
  final DateTime timestamp;

  MessageModel({
    this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id']?.toString(),
      // Ensure we parse IDs and handle potential nulls from Socket data
      conversationId: json['conversationId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      senderName: json['senderName']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'conversationId': conversationId,
    'senderId': senderId,
    'senderName': senderName,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}
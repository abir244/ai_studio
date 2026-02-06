class ChatMessage {
  final String id;
  final String sender;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['_id'] ?? '',
    sender: json['sender'] ?? '',
    message: json['message'] ?? '',
    timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toString()),
  );

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}
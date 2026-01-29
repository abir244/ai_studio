class MessageModel {
  final String sender;
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}

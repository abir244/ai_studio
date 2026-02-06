import 'message_model.dart';

class ConversationModel {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String? userAvatar;
  final MessageModel? lastMessage;
  final int unreadCount;
  final DateTime lastActivity;
  final bool isOnline;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userAvatar,
    this.lastMessage,
    this.unreadCount = 0,
    required this.lastActivity,
    this.isOnline = false,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['id'] ?? json['_id'] ?? '',
        userId: json['userId'] ?? '',
        userName: json['userName'] ?? '',
        userEmail: json['userEmail'] ?? '',
        userAvatar: json['userAvatar'],
        lastMessage: json['lastMessage'] != null
            ? MessageModel.fromJson(json['lastMessage'])
            : null,
        unreadCount: json['unreadCount'] ?? 0,
        lastActivity: json['lastActivity'] != null
            ? DateTime.parse(json['lastActivity'])
            : DateTime.now(),
        isOnline: json['isOnline'] ?? false,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'userName': userName,
    'userEmail': userEmail,
    'userAvatar': userAvatar,
    'lastMessage': lastMessage?.toJson(),
    'unreadCount': unreadCount,
    'lastActivity': lastActivity.toIso8601String(),
    'isOnline': isOnline,
  };

  ConversationModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userEmail,
    String? userAvatar,
    MessageModel? lastMessage,
    int? unreadCount,
    DateTime? lastActivity,
    bool? isOnline,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userAvatar: userAvatar ?? this.userAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      lastActivity: lastActivity ?? this.lastActivity,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
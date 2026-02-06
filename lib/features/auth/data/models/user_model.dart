class UserModel {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final bool isOnline;
  final DateTime? lastSeen;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.isOnline = false,
    this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? json['_id'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    avatar: json['avatar'],
    isOnline: json['isOnline'] ?? false,
    lastSeen: json['lastSeen'] != null
        ? DateTime.parse(json['lastSeen'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'avatar': avatar,
    'isOnline': isOnline,
    'lastSeen': lastSeen?.toIso8601String(),
  };

  String get displayName => username.isNotEmpty ? username : email;

  String get initials {
    if (username.isNotEmpty) {
      final parts = username.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return username.substring(0, 1).toUpperCase();
    }
    return email.substring(0, 1).toUpperCase();
  }
}
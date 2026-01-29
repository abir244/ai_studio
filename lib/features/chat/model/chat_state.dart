import '../data/models/message_model.dart';

class ChatState {
  final List<MessageModel> messages;

  ChatState({required this.messages});

  ChatState copyWith({List<MessageModel>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }
}

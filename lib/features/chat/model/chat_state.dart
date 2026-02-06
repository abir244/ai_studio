import '../data/models/message_model.dart';

class ChatState {
  final List<MessageModel> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
  });

  // Factory for initial state to avoid manual creation in Notifier
  factory ChatState.initial() => const ChatState(messages: [], isLoading: false);

  ChatState copyWith({
    List<MessageModel>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
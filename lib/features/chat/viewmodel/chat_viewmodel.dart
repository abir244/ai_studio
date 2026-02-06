// lib/features/chat/viewmodel/chat_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../model/chat_state.dart';
import '../data/models/message_model.dart'; // Ensure this points to the model above
import '../data/repository/chat_repository_impl.dart';
import '../../auth/viewmodel/auth_providers.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;
  final String conversationId;
  final ChatRepositoryImpl repository;
  late IO.Socket socket;

  ChatNotifier({
    required this.ref,
    required this.conversationId,
    required this.repository,
  }) : super(ChatState.initial()) {
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io('https://your-railway-url.up.railway.app',
        IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('Connected to Socket Room: $conversationId');
      socket.emit('join_room', conversationId);
    });

    // 🔥 FIX: Map JSON to MessageModel before adding to state
    socket.on('receive_message', (data) {
      final json = Map<String, dynamic>.from(data);
      final newMessage = MessageModel.fromJson(json); // Convert JSON to Object
      state = state.copyWith(messages: [...state.messages, newMessage]);
    });

    // 🔥 FIX: Map the List of JSON history to List<MessageModel>
    socket.on('chat_history', (data) {
      if (data is List) {
        final history = data.map((e) {
          return MessageModel.fromJson(Map<String, dynamic>.from(e));
        }).toList();
        state = state.copyWith(messages: history);
      }
    });
  }

  void sendMessage(String text) {
    final user = ref.read(authNotifierProvider).user;
    if (user == null) return;

    // Matches the keys expected by your Node.js chatModel.js
    final msg = {
      'conversationId': conversationId,
      'senderId': user.id,
      'senderName': user.username,
      'message': text,
    };

    socket.emit('send_message', msg);
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
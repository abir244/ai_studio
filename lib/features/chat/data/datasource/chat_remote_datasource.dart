import 'package:socket_io_client/socket_io_client.dart';
import '../models/message_model.dart';

class ChatRemoteDataSource {
  late Socket socket;

  void initSocket() {
    socket = io(
      'http://localhost:4000', // replace with your backend URL
      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.onConnect((_) {
      print('✅ Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('❌ Disconnected from server');
    });
  }

  void sendMessage(MessageModel message) {
    socket.emit('send_message', message.toJson());
  }

  void onReceiveMessage(void Function(MessageModel) callback) {
    socket.on('receive_message', (data) {
      callback(MessageModel.fromJson(data));
    });
  }

  void onChatHistory(void Function(List<MessageModel>) callback) {
    socket.on('chat_history', (data) {
      final messages = (data as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
      callback(messages);
    });
  }
}

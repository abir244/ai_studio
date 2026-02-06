import 'package:socket_io_client/socket_io_client.dart';
import '../models/message_model.dart';

class ChatRemoteDataSource {
  late Socket socket;

  ChatRemoteDataSource() {
    // FIX: Initialize immediately so 'socket' is never null when accessed
    initSocket();
  }

  void initSocket() {
    socket = io(
      "http://192.168.7.72:4000", // <- use your local server IP and port
      OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect() // Ensures it connects automatically
          .build(),
    );


    socket.onConnect((_) => print('✅ Connected to Socket.IO server'));
    socket.onDisconnect((_) => print('❌ Disconnected from server'));

    // Debugging: catch any errors from the socket
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onError((data) => print('Socket Error: $data'));
  }

  void sendMessage(MessageModel message) {
    socket.emit('send_message', message.toJson());
  }

  // FIX: Use dynamic in the handler to prevent casting errors before the Repository handles it
  void onReceiveMessage(void Function(dynamic) handler) {
    socket.on('receive_message', (data) => handler(data));
  }

  void onChatHistory(void Function(dynamic) handler) {
    socket.on('chat_history', (data) => handler(data));
  }
}
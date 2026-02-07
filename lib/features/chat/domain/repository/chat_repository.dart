import 'dart:async';
import '../../data/models/message_model.dart';

abstract class ChatRepository {
  void sendMessage(MessageModel message);

  StreamSubscription<MessageModel> listenMessages(
      void Function(MessageModel) callback,
      );

  void getChatHistory(void Function(List<MessageModel>) callback);
}
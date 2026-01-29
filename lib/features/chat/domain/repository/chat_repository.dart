import '../../data/models/message_model.dart';

abstract class ChatRepository {
  void sendMessage(MessageModel message);
  void listenMessages(void Function(MessageModel) callback);
  void getChatHistory(void Function(List<MessageModel>) callback);
}

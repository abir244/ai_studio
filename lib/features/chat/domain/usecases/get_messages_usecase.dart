import '../repository/chat_repository.dart';
import '../../data/models/message_model.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  void call(void Function(List<MessageModel>) callback) {
    repository.getChatHistory(callback);
  }

  void listen(void Function(MessageModel) callback) {
    repository.listenMessages(callback);
  }
}

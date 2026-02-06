import '../../data/models/message_model.dart';
import '../../domain/repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  // This is the "listen" method your ViewModel is looking for
  void listen(void Function(MessageModel) onMessage) {
    repository.listenMessages(onMessage);
  }

  // This handles the initial history fetch
  void call(void Function(List<MessageModel>) onHistory) {
    repository.getChatHistory(onHistory);
  }
}
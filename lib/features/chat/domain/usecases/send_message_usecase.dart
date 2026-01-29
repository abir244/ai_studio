import '../repository/chat_repository.dart';
import '../../data/models/message_model.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  void call(MessageModel message) {
    repository.sendMessage(message);
  }
}

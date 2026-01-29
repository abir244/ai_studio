import '../datasource/chat_remote_datasource.dart';
import '../models/message_model.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  void sendMessage(MessageModel message) {
    remoteDataSource.sendMessage(message);
  }

  @override
  void listenMessages(void Function(MessageModel) callback) {
    remoteDataSource.onReceiveMessage(callback);
  }

  @override
  void getChatHistory(void Function(List<MessageModel>) callback) {
    remoteDataSource.onChatHistory(callback);
  }
}

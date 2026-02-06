import '../datasource/chat_remote_datasource.dart';
import '../models/message_model.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({ChatRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? ChatRemoteDataSource();

  @override
  void sendMessage(MessageModel message) {
    remoteDataSource.sendMessage(message);
  }

  @override
  void listenMessages(void Function(MessageModel) callback) {
    remoteDataSource.onReceiveMessage((dynamic data) {
      if (data != null && data is Map<String, dynamic>) {
        callback(MessageModel.fromJson(data));
      }
    });
  }

  @override
  void getChatHistory(void Function(List<MessageModel>) callback) {
    remoteDataSource.onChatHistory((dynamic historyData) {
      if (historyData is List) {
        final List<MessageModel> messages = historyData
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
            .toList();
        callback(messages);
      } else {
        callback([]); // Return empty list if data is null or invalid
      }
    });
  }
}
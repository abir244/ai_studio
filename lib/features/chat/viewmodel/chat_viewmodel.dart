import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/chat_state.dart';
import '../data/models/message_model.dart';
import '../data/repository/chat_repository_impl.dart';
import '../data/datasource/chat_remote_datasource.dart';
import '../domain/usecases/get_messages_usecase.dart';
import '../domain/usecases/send_message_usecase.dart';

class ChatViewModel extends StateNotifier<ChatState> {
  final ChatRepositoryImpl repository;
  late final SendMessageUseCase sendMessageUseCase;
  late final GetMessagesUseCase getMessagesUseCase;

  ChatViewModel()
      : repository = ChatRepositoryImpl(remoteDataSource: ChatRemoteDataSource()),
        super(ChatState(messages: [])) {
    repository.remoteDataSource.initSocket();
    sendMessageUseCase = SendMessageUseCase(repository);
    getMessagesUseCase = GetMessagesUseCase(repository);

    // get initial chat history
    getMessagesUseCase((messages) {
      state = state.copyWith(messages: messages);
    });

    // listen for new messages
    getMessagesUseCase.listen((message) {
      state = state.copyWith(messages: [...state.messages, message]);
    });
  }

  void sendMessage(String sender, String message) {
    final msg = MessageModel(
      sender: sender,
      message: message,
      timestamp: DateTime.now(),
    );
    sendMessageUseCase(msg);
    state = state.copyWith(messages: [...state.messages, msg]);
  }
}

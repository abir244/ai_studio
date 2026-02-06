import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'chat_viewmodel.dart';
import '../model/chat_state.dart';
import '../data/repository/chat_repository_impl.dart';

// 1. Create a provider for the Repository itself
final chatRepositoryProvider = Provider<ChatRepositoryImpl>((ref) {
  return ChatRepositoryImpl();
});

// 2. Use the repository provider inside your ChatProvider
final chatProvider = StateNotifierProvider.autoDispose
    .family<ChatNotifier, ChatState, String>((ref, conversationId) {

  // We "watch" the repository instead of creating it manually
  final repository = ref.watch(chatRepositoryProvider);

  return ChatNotifier(
    ref: ref,
    conversationId: conversationId,
    repository: repository,
  );
});
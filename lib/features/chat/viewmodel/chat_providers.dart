import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'chat_viewmodel.dart';

final chatViewModelProvider =
StateNotifierProvider<ChatViewModel, dynamic>((ref) => ChatViewModel());

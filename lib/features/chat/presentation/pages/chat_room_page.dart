import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../viewmodel/chat_providers.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_bubble.dart';
 // Using your existing AppColors

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({super.key});

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController nameController = TextEditingController(text: "Me");
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    nameController.dispose();
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);

    // Auto-scroll when new messages arrive
    ref.listen(chatViewModelProvider, (prev, next) {
      if (prev?.messages.length != next.messages.length) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Soft background color
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dynamic Chat',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${chatState.messages.length} messages',
              style: TextStyle(color: Colors.green.shade600, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Identity Section (Sets the 'Name')
          _buildIdentityBanner(),

          // Chat Messages
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: chatState.messages.length,
                  itemBuilder: (_, index) {
                    final MessageModel msg = chatState.messages[index];
                    final isMe = msg.sender == nameController.text.trim();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChatBubble(message: msg, isMe: isMe),
                    );
                  },
                ),
              ),
            ),
          ),

          // Modern Input Bar
          _buildInputArea(ref),
        ],
      ),
    );
  }

  Widget _buildIdentityBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryPurple.withOpacity(0.1),
            child: Icon(Icons.person, color: AppColors.primaryPurple, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Your Display Name...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14),
              ),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Text(
            "CHATTING AS",
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
        bottom: MediaQuery.of(context).padding.bottom + 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6F9),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              final name = nameController.text.trim();
              final message = messageController.text.trim();
              if (name.isEmpty || message.isEmpty) return;

              ref.read(chatViewModelProvider.notifier).sendMessage(name, message);
              messageController.clear();
              HapticFeedback.mediumImpact();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient, // Using your existing gradient
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
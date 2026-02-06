import 'package:flutter/material.dart';
import '../../../../core/routes/route_name.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  final TextEditingController _roomCodeController = TextEditingController();

  void _joinRoom() {
    final code = _roomCodeController.text.trim();
    if (code.isEmpty) return;

    // Navigate to ChatRoomPage with room code
    Navigator.pushNamed(
      context,
      RouteName.ChatRoom,
      arguments: {
        'conversationId': code,
        'conversationName': "Room $code",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomCodeController,
              decoration: const InputDecoration(
                labelText: "Enter Room Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinRoom,
              child: const Text("Join Room"),
            ),
          ],
        ),
      ),
    );
  }
}

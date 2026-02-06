import 'package:flutter/material.dart';
import '../../../../core/routes/route_name.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final TextEditingController _roomNameController = TextEditingController();

  void _createRoom() {
    final name = _roomNameController.text.trim();
    if (name.isEmpty) return;

    // Generate a simple random room code
    final code = DateTime.now().millisecondsSinceEpoch.toString().substring(7);

    // Navigate to ChatRoomPage with code
    Navigator.pushNamed(
      context,
      RouteName.ChatRoom,
      arguments: {
        'conversationId': code,
        'conversationName': name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _roomNameController,
              decoration: const InputDecoration(
                labelText: "Room Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createRoom,
              child: const Text("Create & Join"),
            ),
          ],
        ),
      ),
    );
  }
}

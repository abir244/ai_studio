// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/routes/route_name.dart';
// import '../../../auth/viewmodel/auth_providers.dart';
//  // we'll create this
//
// class UserListPage extends ConsumerWidget {
//   const UserListPage({super.key});
//
//   // Helper to create a consistent ID for personal chat
//   String _getRoomId(String idA, String idB) {
//     List<String> ids = [idA, idB];
//     ids.sort();
//     return ids.join("_");
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authNotifierProvider);
//     final currentUser = authState.user;
//
//     // Watch the provider that fetches users from backend
//    // final userListState = ref.watch(userListProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contacts & Rooms"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             tooltip: 'Create Custom Room',
//             onPressed: () {
//               Navigator.pushNamed(context, RouteName.CreateRoomPage);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.meeting_room),
//             tooltip: 'Join Room by Code',
//             onPressed: () {
//               Navigator.pushNamed(context, RouteName.JoinRoomPage);
//             },
//           ),
//         ],
//       ),
//       body: currentUser == null
//           ? _buildLoginError()
//       //    : userListState.when(
//         data: (users) {
//           // Filter out myself
//           final filteredUsers =
//           users.where((u) => u.id != currentUser.id).toList();
//
//           if (filteredUsers.isEmpty) {
//             return const Center(child: Text("No other users found."));
//           }
//
//           return ListView.separated(
//             itemCount: filteredUsers.length,
//             separatorBuilder: (context, index) => const Divider(height: 1),
//             itemBuilder: (context, index) {
//               final otherUser = filteredUsers[index];
//
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.purple[100],
//                   child: Text(otherUser.username[0]),
//                 ),
//                 title: Text(otherUser.username),
//                 onTap: () {
//                   final roomId = _getRoomId(currentUser.id, otherUser.id);
//                   Navigator.pushNamed(
//                     context,
//                     RouteName.ChatRoom,
//                     arguments: {
//                       'conversationId': roomId,
//                       'conversationName': otherUser.username,
//                     },
//                   );
//                 },
//               );
//             },
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text("Error: $err")),
//       ),
//     );
//   }
//
//   Widget _buildLoginError() {
//     return const Center(
//       child: Text(
//         "User identity not found. Please log out and log in again.",
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

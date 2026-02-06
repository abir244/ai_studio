// lib/features/chat/data/repository/user_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../auth/data/models/user_model.dart';


class UserRepository {
  final http.Client client;
  static const String baseUrl = "http://localhost:4000"; // replace with your backend URL

  UserRepository(this.client);

  Future<List<UserModel>> fetchUsers() async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/auth/users'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}

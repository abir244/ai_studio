import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  // For Android Emulator:
  static const String baseUrl ="http://localhost:4000";
     // "https://backendchatapp-production-f26a.up.railway.app";

  // For iOS Simulator: "http://localhost:4000"
  // For Physical Device: "http://YOUR_COMPUTER_IP:4000"

  final http.Client client;

  AuthRemoteDataSource(this.client);

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/api/auth/register'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Registration failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/api/auth/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> testConnection() async {
    try {
      final response = await client
          .get(
            Uri.parse('$baseUrl/api/hello'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      print('✅ Backend connection: ${response.statusCode}');
    } catch (e) {
      print('❌ Cannot connect to backend: $e');
      rethrow;
    }
  }
}

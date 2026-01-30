
import 'package:ai_studio/features/auth/data/models/user_model.dart';

class AuthState {
  final bool isLoading;
  final UserModel? user;
  final String? error;

  AuthState({
    required this.isLoading,
    this.user,
    this.error,
  });

  factory AuthState.initial() => AuthState(isLoading: false);

  factory AuthState.loading() => AuthState(isLoading: true);

  factory AuthState.authenticated(UserModel user) =>
      AuthState(isLoading: false, user: user);

  factory AuthState.error(String error) =>
      AuthState(isLoading: false, error: error);
}
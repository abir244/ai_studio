// lib/features/auth/data/models/auth_state.dart
import 'user_model.dart';

class AuthState {
  final bool isLoading;
  final UserModel? user;
  final String? error;

  AuthState({
    required this.isLoading,
    this.user,
    this.error,
  });

  /// Initial state: not loading, no user, no error
  factory AuthState.initial() => AuthState(isLoading: false);

  /// Loading state
  factory AuthState.loading() => AuthState(isLoading: true);

  /// Authenticated state
  factory AuthState.authenticated(UserModel user) =>
      AuthState(isLoading: false, user: user);

  /// Error state
  factory AuthState.error(String error) =>
      AuthState(isLoading: false, error: error);

  /// Convenience method to check if user is logged in
  bool get isAuthenticated => user != null;

  /// Convenience method to get username or empty string
  String get username => user?.username ?? '';
}

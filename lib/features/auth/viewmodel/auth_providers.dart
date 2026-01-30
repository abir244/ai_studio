// lib/features/auth/viewmodel/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/datasource/auth_remote_datasource.dart';
import '../data/models/auth_state.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';

// ========== PROVIDERS ==========

// HTTP Client Provider
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// Data Source Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRemoteDataSource(client);
});

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: dataSource);
});

// Use Case Providers
final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUsecase(repository);
});

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUsecase(repository);
});

// Auth Notifier Provider (Replaces ViewModel)
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading();

    try {
      final loginUsecase = ref.read(loginUsecaseProvider);
      final user = await loginUsecase.execute(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register(String username, String email, String password) async {
    state = AuthState.loading();

    try {
      final registerUsecase = ref.read(registerUsecaseProvider);
      final user = await registerUsecase.execute(username, email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = AuthState.initial();
  }
}

// Legacy provider for compatibility (if other code uses it)
final authViewModelProvider = authNotifierProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// IMPORTANT: Replace these imports with your actual file paths
import '../data/models/auth_state.dart';
import '../data/models/user_model.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../data/repository/auth_repository_impl.dart';
import '../data/datasource/auth_remote_datasource.dart';

// =========================================================
// 1. Dependency Injection (Define these OUTSIDE the class)
// =========================================================

final httpClientProvider = Provider((ref) => http.Client());

final authRemoteDataSourceProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRemoteDataSource(client);
});

final authRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: dataSource);
});

// These are the providers your AuthNotifier was looking for
final loginUsecaseProvider = Provider((ref) {
  return LoginUsecase(ref.watch(authRepositoryProvider));
});

final registerUsecaseProvider = Provider((ref) {
  return RegisterUsecase(ref.watch(authRepositoryProvider));
});

// =========================================================
// 2. Auth Notifier Provider
// =========================================================

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

// Provider to easily access the current user's name across the app
final currentUsernameProvider = Provider<String>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.user?.username ?? '';
});

// =========================================================
// 3. The AuthNotifier Class
// =========================================================

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Automatically try to load a saved user when the app starts
    _loadSession();
    return AuthState.initial();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userId');
    final String? name = prefs.getString('username');
    final String? email = prefs.getString('email');

    if (id != null && name != null) {
      state = AuthState.authenticated(
        UserModel(id: id, username: name, email: email ?? ''),
      );
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      // Accessing the global provider using the built-in 'ref'
      final loginUsecase = ref.read(loginUsecaseProvider);
      final user = await loginUsecase.execute(email, password);

      await _persistUser(user);
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

      await _persistUser(user);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> _persistUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = AuthState.initial();
  }
}
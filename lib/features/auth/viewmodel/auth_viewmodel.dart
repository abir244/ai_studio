import 'package:flutter/foundation.dart';

import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../data/models/auth_state.dart';


class AuthViewModel extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthState _state = AuthState.initial();
  AuthState get state => _state;

  AuthViewModel({
    required this.loginUsecase,
    required this.registerUsecase,
  });

  Future<void> login(String email, String password) async {
    _state = AuthState.loading();
    notifyListeners();

    try {
      final user = await loginUsecase.execute(email, password);
      _state = AuthState.authenticated(user);
      notifyListeners();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> register(String username, String email, String password) async {
    _state = AuthState.loading();
    notifyListeners();

    try {
      final user = await registerUsecase.execute(username, email, password);
      _state = AuthState.authenticated(user);
      notifyListeners();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  void logout() {
    _state = AuthState.initial();
    notifyListeners();
  }
}
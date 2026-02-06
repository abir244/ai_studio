
import '../../data/models/user_model.dart';
import '../auth_repository.dart';
class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserModel> execute(String username, String email, String password) async {
    // 1. Basic Validation Logic
    if (username.length < 3) {
      throw Exception("Username must be at least 3 characters long.");
    }
    if (!email.contains('@')) {
      throw Exception("Please enter a valid email address.");
    }
    if (password.length < 6) {
      throw Exception("Password must be at least 6 characters.");
    }

    // 2. Delegate to Repository
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
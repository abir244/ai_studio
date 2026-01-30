
import '../../data/models/user_model.dart';
import '../auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserModel> execute(String username, String email, String password) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
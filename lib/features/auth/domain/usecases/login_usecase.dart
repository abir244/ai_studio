
import '../../data/models/user_model.dart';
import '../auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<UserModel> execute(String email, String password) async {
    return await repository.login(email: email, password: password);
  }
}
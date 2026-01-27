import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<UserModel> register(String name, String email, String password) {
    return remoteDataSource.register(name, email, password);
  }
}

import '../../domain/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

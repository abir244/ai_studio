import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/auth_state.dart';
import 'auth_viewmodel.dart';
import '../data/datasource/auth_remote_datasource.dart';
import '../data/repository/auth_repository_impl.dart';
import '../domain/repository/auth_repository.dart';

// Remote datasource provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remote);
});

// ViewModel provider
final authViewModelProvider =
StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return AuthViewModel(repository);
});

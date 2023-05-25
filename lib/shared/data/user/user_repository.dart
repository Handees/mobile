import 'package:handees/shared/data/user/datasources/local.dart';
import 'package:handees/shared/data/user/datasources/remote.dart';

class UserRepository {
  static UserRepository? _instance;

  UserRepository._();

  factory UserRepository() {
    return _instance ??= UserRepository._();
  }

  final remote = UserRemoteDataSource();
  final local = UserLocalDataSource();
}

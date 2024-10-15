import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/services/local/auth_services.dart';

abstract class AuthRepository {
  Future<User?> getLoggedInUser();
  Future<void> logInUser({required User userData});
  Future<void> logOutUser();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  @override
  Future<User?> getLoggedInUser() async {
    return await AuthService.getLoggedInUser();
  }

  @override
  Future<void> logInUser({required User userData}) async {
    await AuthService.logInUser(userData);
  }

  @override
  Future<void> logOutUser() async {
    await AuthService.logOutUser();
  }
}

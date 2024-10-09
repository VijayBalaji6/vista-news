import 'package:vista_news/models/user.dart';
import 'package:vista_news/services/local/auth_services.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<User?> getLoggedInUser() async {
    return await _authService.getLoggedInUser();
  }

  Future<void> logInUser({required User userData}) async {
    await _authService.logInUser(userData);
  }

  Future<void> logOutUser() async {
    await _authService.logOutUser();
  }
}

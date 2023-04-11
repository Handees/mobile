import 'package:flutter/foundation.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/utils/utils.dart';

class SigninViewmodel extends ChangeNotifier with InputValidationMixin {
  SigninViewmodel(this._authService);

  final AuthService _authService;

  String _email = '';
  String _password = '';

  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  bool _loading = false;
  bool get loading => _loading;

  void onEmailSaved(String? email) => _email = email!;
  void onPasswordSaved(String? password) => _password = password!;

  String? emailValidator(String? email) {
    if (email != null && isEmailValid(email)) {
      return null;
    }

    return 'Invalid email';
  }

  String? passwordValidator(String? password) {
    if (password != null && isPasswordValid(password)) {
      return null;
    }

    return 'Invalid password';
  }

  Future<void> signinUser({
    required void Function() onSuccess,
    required void Function() onUnknownError,
  }) async {
    _loading = true;
    resetErrors();
    notifyListeners();

    final response = await _authService.signinUser(_email, _password);

    switch (response) {
      case AuthResponse.success:
        onSuccess();
        break;
      case AuthResponse.incorrectPassword:
        _passwordError = 'Incorrect password';
        break;
      case AuthResponse.noSuchEmail:
        _emailError = 'No account exists with this email';
        break;
      case AuthResponse.unknownError:
        onUnknownError();
        break;
      default:
        onUnknownError();
    }
    _loading = false;
    notifyListeners();
  }

  void resetErrors() {
    _emailError = null;
    _passwordError = null;
  }
}

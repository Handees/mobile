import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/features/auth/services/auth_service.dart';
import 'package:handees/utils/utils.dart';

final authProvider = StateNotifierProvider<AuthModel, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthModel(authService);
});

class AuthModel extends StateNotifier<AuthState> with InputValidationMixin {
  final authInstance = FirebaseAuth.instance;

  final AuthService authService;

  String _name = '';
  String _phone = '';
  String _email = '';
  String _password = '';

  // bool obscureText = true;

  // void toggle

  void signinUser() async {
    // if (!_formGlobalKey.currentState!.validate()) return;

    // _formGlobalKey.currentState?.save();
    // print(
    //     'Email: $email, Password: $password, Name: $name');
    state = AuthState.loading;
    final response = await authService.signinUser(_email, _password);
    // await Future.delayed(Duration(seconds: 2));

    switch (response) {
      case AuthResponse.success:
        state = AuthState.authenticated;
        break;
      case AuthResponse.incorrectPassword:
        state = AuthState.invalidPassword;
        break;
      case AuthResponse.noSuchEmail:
        state = AuthState.noSuchEmail;
        break;
      case AuthResponse.unknownError:
        state = AuthState.waiting;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  void signupUser() async {
    state = AuthState.loading;
    final response = await authService.signupUser(
      email: _email,
      password: _password,
      name: _name,
      phone: _phone,
    );
    // await Future.delayed(Duration(seconds: 2));

    switch (response) {
      case AuthResponse.success:
        state = AuthState.authenticated;
        break;
      case AuthResponse.weakPassword:
        state = AuthState.invalidPassword;
        break;
      case AuthResponse.emailInUse:
        state = AuthState.emailInUse;
        break;
      case AuthResponse.invalidPhone:
        state = AuthState.invalidPhone;
        break;

      case AuthResponse.phoneInUse:
        state = AuthState.phoneInUse;
        break;
      case AuthResponse.unknownError:
        state = AuthState.waiting;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  void signoutUser() {
    resetState();
    authService.signoutUser();
  }

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

  String? nameValidator(String? name) {
    if (name != null && name.isNotEmpty) {
      return null;
    }

    const errorMessage = 'Name must be at least a character';
    return errorMessage;
  }

  String? phoneValidator(String? phone) {
    if (phone != null && isNumberValid(phone)) {
      return null;
    }

    return 'Invalid phone';
  }

  void onEmailSaved(String? email) => _email = email!;
  void onPasswordSaved(String? password) => _password = password!;
  void onNameSaved(String? name) => _name = name!;
  void onPhoneSaved(String? phone) => _phone = phone!;

  void resetState() {
    _email = '';
    _name = '';
    _password = '';
    _phone = '';
    state = AuthState.waiting;
  }

  AuthModel(this.authService)
      : super(FirebaseAuth.instance.currentUser == null
            ? AuthState.waiting
            : AuthState.authenticated);
}

enum AuthState {
  waiting,
  loading,
  authenticated,
  noSuchEmail,
  invalidPassword,
  invalidPhone,
  emailInUse,
  phoneInUse,
}

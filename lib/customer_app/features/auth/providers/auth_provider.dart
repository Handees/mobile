import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/res/constants.dart';
import 'package:handees/utils/utils.dart';

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  // final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(AuthService.instance);
});

class AuthStateNotifier extends StateNotifier<AuthState>
    with InputValidationMixin {
  AuthStateNotifier(this._authService) : super(AuthState.waiting);

  final AuthService _authService;

  String _name = '';
  String _phone = '';
  String _email = '';
  String _password = '';

  String _smsCode = '';
  set smsCode(String code) => _smsCode = code;
  late String _verificationId;

  String get last2Digits => _phone.substring(_phone.length - 2, _phone.length);

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

  Future<void> signinUser() async {
    state = AuthState.loading;
    final response = await _authService.signinUser(_email, _password);

    switch (response) {
      case AuthResponse.success:
        state = AuthState.waiting; // AuthState.authenticated;
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

  Future<void> _completeProfile(
    String email,
    String password,
    String name,
  ) async {
    final completeResponse =
        await _authService.completeProfile(_email, _password, _name);

    switch (completeResponse) {
      case AuthResponse.success:
        print('Verfication completed');
        final user = _authService.user;
        final result = await _authService.submitUserData(
          name: user.displayName!,
          phone: user.phoneNumber!,
          email: user.email!,
          uid: user.uid,
        );
        //TODO: check this
        state = result == AuthResponse.success
            ? AuthState.waiting //AuthState.authenticated
            : AuthState.error;
        break;
      case AuthResponse.weakPassword:
        state = AuthState.invalidPassword;
        break;
      case AuthResponse.emailInUse:
        state = AuthState.emailInUse;
        break;
      case AuthResponse.invalidEmail:
        state = AuthState.invalidEmail;
        break;
      case AuthResponse.unknownError:
        state = AuthState.waiting;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  void verifyNumber() => _verifyNumber();

  Future<void> _verifyNumber({PhoneAuthCredential? phoneAuthCredential}) async {
    state = AuthState.loading;
    PhoneAuthCredential credential = phoneAuthCredential ??
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _smsCode,
        );
    final response = await _authService.verifyNumber(credential);
    // await Future.delayed(Duration(seconds: 2));

    switch (response) {
      case AuthResponse.success:
        _completeProfile(_email, _password, _name);

        break;
      case AuthResponse.phoneInUse:
        state = AuthState.phoneInUse;
        break;
      case AuthResponse.invalidPhone:
        state = AuthState.invalidPhone;
        break;
      case AuthResponse.invalidVerificationCode:
        state = AuthState.invalidVerificationCode;
        break;
      case AuthResponse.unknownError:
        state = AuthState.waiting;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  Future<void> signupUser({required void Function() onCodeSent}) async {
    state = AuthState.loading;
    print('Signing up user');

    if (await _authService.emailInUse(_email)) {
      state = AuthState.emailInUse;
      return;
    }

    _authService.signupWithPhone(
      phone: _phone,
      onCodeSent: (verificationId, forceResendingToken) {
        state = AuthState.verifying;
        _verificationId = verificationId;
        onCodeSent();
      },
      onVerifcationComplete: (phoneAuthCredential) {
        _verifyNumber(phoneAuthCredential: phoneAuthCredential);
      },
      onVerificationFailed: (error) {
        debugPrint('Phone verification failed with error $error');
        state = AuthState.error;
      },
    );
  }

  // void signoutUser() {
  //   resetState();
  //   authService.signoutUser();
  // }

  void resetState() {
    _email = '';
    _name = '';
    _password = '';
    _phone = '';
    state = AuthState.waiting;
  }
}

enum AuthState {
  waiting,
  loading,
  verifying,
  // authenticated,
  noSuchEmail,
  invalidPassword,
  invalidPhone,
  invalidVerificationCode,
  invalidEmail,
  emailInUse,
  phoneInUse,
  error,
}

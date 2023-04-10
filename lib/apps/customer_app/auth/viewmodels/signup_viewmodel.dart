import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/utils/utils.dart';

class SignupNotifier extends ChangeNotifier with InputValidationMixin {
  SignupNotifier(this._authService);

  final AuthService _authService;

  String _name = '';
  String _phone = '';
  String _email = '';
  String _password = '';

  String get last2Digits => _phone.substring(_phone.length - 2, _phone.length);

  String _smsCode = '';
  set smsCode(String code) => _smsCode = code;
  late String _verificationId;

  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  String? _phoneError;
  String? get phoneError => _phoneError;

  bool _loading = false;
  bool get loading => _loading;

  void onEmailSaved(String? email) => _email = email!;
  void onPasswordSaved(String? password) => _password = password!;
  void onNameSaved(String? name) => _name = name!;
  void onPhoneSaved(String? phone) => _phone = phone!;

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

  Future<void> _completeProfile({
    required void Function() onSuccess,
    required void Function() onUnknownError,
  }) async {
    final completeResponse = await _authService.updateFirebaseProfile(
        email: _email, password: _password, name: _name);

    switch (completeResponse) {
      case AuthResponse.success:
        debugPrint('Verfication completed');
        onSuccess();
        break;
      case AuthResponse.weakPassword:
        _passwordError = 'Password too weak';
        break;
      case AuthResponse.emailInUse:
        _emailError = 'An account already exists with this email';
        break;
      case AuthResponse.invalidEmail:
        _emailError = 'Not a valid email';
        break;
      case AuthResponse.unknownError:
        onUnknownError();
        break;
      default:
        onUnknownError();
    }
    notifyListeners();
  }

  void verifyNumber({
    required void Function() onSuccess,
    required void Function() onUnknownError,
  }) =>
      _verifyNumber(onSuccess: onSuccess, onUnknownError: onUnknownError);

  Future<void> _verifyNumber({
    PhoneAuthCredential? phoneAuthCredential,
    required void Function() onSuccess,
    required void Function() onUnknownError,
  }) async {
    _loading = true;
    notifyListeners();
    PhoneAuthCredential credential = phoneAuthCredential ??
        PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _smsCode,
        );

    final response = await _authService.verifyNumber(credential);

    switch (response) {
      case AuthResponse.success:
        _completeProfile(onSuccess: () {}, onUnknownError: () {});

        break;
      case AuthResponse.phoneInUse:
        _phoneError = 'An account already exists with this phone number';
        break;
      case AuthResponse.invalidPhone:
        _phoneError = 'Not a valid phone number';
        break;
      case AuthResponse.invalidVerificationCode:
        //TODO
        // state = AuthState.invalidVerificationCode;
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

  Future<void> signupUser({
    required void Function() onCodeSent,
    required void Function() onVerificationComplete,
  }) async {
    _loading = true;
    notifyListeners();
    if (await _authService.emailInUse(_email)) {
      _emailError = 'An account already exists with this email';
      return;
    }

    _authService.signupWithPhone(
      phone: _phone,
      onCodeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        onCodeSent();
      },
      onVerifcationComplete: (phoneAuthCredential) {
        _verifyNumber(phoneAuthCredential: phoneAuthCredential);
      },
      onVerificationFailed: (error) {
        debugPrint('Phone verification failed with error $error');
        // state = AuthState.error;
      },
    );
  }
}

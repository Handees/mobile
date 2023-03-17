import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/auth/providers/auth_provider.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/services/user_data_service.dart';
import 'package:handees/utils/utils.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AuthState>((ref) {
  return
      //  AuthNotifierTest(ref, AuthService.instance);
      ProfileNotifier(
          ref.watch(authServiceProvider), ref.watch(userDataServiceProvider));
});

class ProfileNotifier extends StateNotifier<AuthState>
    with InputValidationMixin {
  ProfileNotifier(this._authService, this._userDataService)
      : super(AuthState.waiting);

  final AuthService _authService;
  final UserDataService _userDataService;

  String _smsCode = '';
  set smsCode(String code) => _smsCode = code;
  late String _verificationId;

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

  Future<void> updateUsername(String name) async {
    final completeResponse =
        await _authService.updateFirebaseProfile(name: name);

    switch (completeResponse) {
      case AuthResponse.success:
        debugPrint('Verfication completed');
        _userDataService.updateUserData(
          name: name,
          phone: _authService.user.phoneNumber!,
          email: _authService.user.email!,
          uid: _authService.user.uid,
          token: _authService.token,
        );
        state = AuthState.authenticated;
        break;
      case AuthResponse.unknownError:
        state = AuthState.error;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  Future<void> updateEmail(String email) async {
    final completeResponse =
        await _authService.updateFirebaseProfile(email: email);

    switch (completeResponse) {
      case AuthResponse.success:
        debugPrint('Verfication completed');
        state = AuthState.authenticated;
        break;
      case AuthResponse.emailInUse:
        state = AuthState.emailInUse;
        break;
      case AuthResponse.invalidEmail:
        state = AuthState.invalidEmail;
        break;
      case AuthResponse.unknownError:
        state = AuthState.error;
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

    switch (response) {
      case AuthResponse.success:
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
        state = AuthState.error;
        break;
      default:
        state = AuthState.waiting;
    }
  }

  Future<void> updatePhone(String phone,
      {required void Function() onCodeSent}) async {
    state = AuthState.loading;

    _authService.signupWithPhone(
      phone: phone,
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

  void signoutUser() {
    resetState();
    _authService.signoutUser();
  }

  void resetState() {
    smsCode = '';

    if (mounted) {
      state = AuthState.waiting;
    }
  }
}

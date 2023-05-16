import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/utils/utils.dart';

enum ArtisanAuthState {
  waiting,
  loading,
  verifying,
  authenticated,
  noSuchEmail,
  invalidPassword,
  invalidPhone,
  invalidVerificationCode,
  invalidEmail,
  emailInUse,
  phoneInUse,
  error,
}

enum SubmitStatus {
  notSubmitted,
  submitted,
  submitError,
}

final artisanAuthProvider =
    StateNotifierProvider<ArtisanAuthStateNotifier, ArtisanAuthState>((ref) {
  return
      //  AuthNotifierTest(ref, AuthService.instance);
      ArtisanAuthStateNotifier(AuthService.instance);
});

class ArtisanAuthStateNotifier extends StateNotifier<ArtisanAuthState>
    with InputValidationMixin {
  ArtisanAuthStateNotifier(this._authService)
      : super(ArtisanAuthState.waiting) {
    // _authService.firebaseAuth.userChanges().listen((user) {
    //   if (_authService.isAuthenticated() &&
    //       _authService.isProfileComplete() &&
    //       submitStatus != SubmitStatus.submitted) {
    //     trySubmitData(
    //       name: user!.displayName!,
    //       phone: user.phoneNumber!,
    //       email: user.email!,
    //       uid: user.uid,
    //     );
    //   }
    // });
  }

  final AuthService _authService;

  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _address = '';

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

  void onFirstNameSaved(String? firstName) => _firstName = firstName!;
  void onLastNameSaved(String? lastName) => _lastName = lastName!;
  void onAddressSaved(String? address) => _address = address!;
  void onPhoneSaved(String? phone) => _phone = phone!;

  Future<void> _completeProfile() async {
    // final completeResponse =
    //     await _authService.completeProfile(_email, _password, _name);

    // switch (completeResponse) {
    //   case AuthResponse.success:
    //     debugPrint('Verfication completed');
    //     state = ArtisanAuthState.authenticated;
    //     break;
    //   case AuthResponse.weakPassword:
    //     state = ArtisanAuthState.invalidPassword;
    //     break;
    //   case AuthResponse.emailInUse:
    //     state = ArtisanAuthState.emailInUse;
    //     break;
    //   case AuthResponse.invalidEmail:
    //     state = ArtisanAuthState.invalidEmail;
    //     break;
    //   case AuthResponse.unknownError:
    //     state = ArtisanAuthState.error;
    //     break;
    //   default:
    //     state = ArtisanAuthState.waiting;
    // }
  }

  void resetState() {
    _address = '';
    _firstName = '';
    _lastName = '';
    _phone = '';

    if (mounted) {
      state = ArtisanAuthState.waiting;
    }
  }
}

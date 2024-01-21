import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/kyc/data/id_info.dart';

final idTypeProvider = StateProvider((ref) => idTypes[0]);

final List<String> idTypes = [
  IDTypes.nin,
  IDTypes.driverLicense,
  IDTypes.passport
];

abstract class IDTypes {
  static const String nin = "National Identification Number";
  static const String driverLicense = "Drivers' License";
  static const String passport = "International Passport";
}

final idInfoProvider = StateNotifierProvider<IdInfoStateNotifier, IdInfo>(
    (ref) => IdInfoStateNotifier(ref));

class IdInfoStateNotifier extends StateNotifier<IdInfo> {
  final StateNotifierProviderRef ref;
  IdInfoStateNotifier(this.ref) : super(IdInfo.empty());

  void updateImageUrl(String imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }

  void updateDOB(DateTime dateOfBirth) {
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void updateNIN(String nin) {
    state = state.copyWith(nin: nin);
  }

  void updateFrscNo(String frscNo) {
    state = state.copyWith(frscNo: frscNo);
  }

  void updateLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void updatePassportNo(String passportNo) {
    state = state.copyWith(passportNo: passportNo);
  }

  String validate() {
    final idType = ref.read(idTypeProvider);

    if (idType == idTypes[0]) {
      if (state.imageUrl.isEmpty) return 'NIN Slip was not uploaded';
      if (state.nin.isEmpty) return 'NIN number field is empty';
    }

    if (idType == idTypes[1]) {
      if (state.imageUrl.isEmpty) return 'Drivers\' License was not uploaded';
      if (state.frscNo.isEmpty) return 'FRSC number field is empty';
      final currDate = DateTime.now();
      final validAgeMinDate =
          DateTime(currDate.year - 18, currDate.month, currDate.day);
      if (state.dateOfBirth.isAfter(validAgeMinDate)) {
        return 'This user is too young';
      }
    }

    if (idType == idTypes[2]) {
      if (state.imageUrl.isEmpty) return 'Passport Data Page was not uploaded';
      if (state.lastName.isEmpty) return 'Last name field is empty';
      if (state.passportNo.isEmpty) return 'Passport number field is empty';
    }

    return '';
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:handees/shared/data/user/user_repository.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/utils/utils.dart';

enum ArtisanSwitchState { loading, success, error, none }

final jobCategoryProvider =
    StateNotifierProvider<_JobCategoryStateNotifier, JobCategory>(
        (ref) => _JobCategoryStateNotifier());

class _JobCategoryStateNotifier extends StateNotifier<JobCategory> {
  _JobCategoryStateNotifier() : super(JobCategory.values.first);

  void updateJobCategory(JobCategory newJobCategory) {
    state = newJobCategory;
  }
}

final artisanSwitchStateProvider =
    StateNotifierProvider<ArtisanSwitchStateNotifier, ArtisanSwitchState>(
        (ref) => ArtisanSwitchStateNotifier(ref));

class ArtisanSwitchStateNotifier extends StateNotifier<ArtisanSwitchState> {
  final StateNotifierProviderRef _ref;
  ArtisanSwitchStateNotifier(this._ref) : super(ArtisanSwitchState.none);

  int _hourlyRate = 0;
  String _jobTitle = "";

  final _userRepository = UserRepository();
  final _authService = AuthService.instance;

  void onHourlyRateSaved(String? hourlyRate) {
    if (hourlyRate != null) {
      _hourlyRate = int.parse(hourlyRate);
    }
  }

  void onJobTitleSaved(String? jobTitle) {
    if (jobTitle != null) {
      _jobTitle = jobTitle;
    }
  }

  String? jobTitleValidator(String? jobTitle) {
    if (jobTitle != null && jobTitle.isNotEmpty) {
      return null;
    }

    return 'Job title is empty';
  }

  String? hourlyRateValidator(String? hourlyRate) {
    if (hourlyRate != null && hourlyRate.isNotEmpty) {
      int num;
      try {
        num = int.parse(hourlyRate);
      } catch (e) {
        return 'Hourly Rate must be a number';
      }

      if (num <= 0) {
        return 'Hourly Rate must be greater than 0';
      } else {
        return null;
      }
    }

    return "Hourly Rate is empty";
  }

  void onJobCategoryChanged(JobCategory? jobCategory) {
    if (jobCategory != null) {
      _ref.read(jobCategoryProvider.notifier).updateJobCategory(jobCategory);
    }
  }

  Future<void> createArtisanProfile({
    required void Function() onSuccess,
  }) async {
    state = ArtisanSwitchState.loading;

    try {
      final response = await _userRepository.submitArtisanData(
        uid: _authService.user.uid,
        hourlyRate: _hourlyRate,
        jobCategory: _ref.read(jobCategoryProvider).id,
        jobTitle: _jobTitle,
        token: _authService.token,
      );

      if (response) {
        state = ArtisanSwitchState.success;
        onSuccess();
      } else {
        state = ArtisanSwitchState.error;
      }
    } catch (e) {
      ePrint(e);
      state = ArtisanSwitchState.error;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/auth/providers/auth_provider.dart';
import 'package:handees/customer_app/models/job_category.dart';
import 'package:handees/customer_app/services/auth_service.dart';

final nameProvider = Provider<String>((ref) {
  //TODO: probably get all user details
  return AuthService.instance.user.displayName ?? "";
});

final categoryProvider = Provider<List<JobCategory>>((ref) {
  return jobCategories;
});

final userDataStatusProvider = Provider<SubmitStatus>((ref) {
  return ref.watch(authProvider.notifier).submitted;
});

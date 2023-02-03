import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/auth/providers/auth_provider.dart';
import 'package:handees/data/handees/job_category.dart';
import 'package:handees/services/auth_service.dart';

final nameProvider = Provider<String>((ref) {
  //TODO: probably get all user details
  return ref.watch(authServiceProvider).user.displayName ?? "";
});

final categoryProvider = Provider<List<JobCategory>>((ref) {
  return jobCategories;
});

final userDataStatusProvider = Provider<SubmitStatus>((ref) {
  return ref.watch(authProvider.notifier).submitted;
});

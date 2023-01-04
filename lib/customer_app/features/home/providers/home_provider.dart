import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/auth/providers/auth_provider.dart';
import 'package:handees/customer_app/models/job_category.dart';
import 'package:handees/customer_app/services/auth_service.dart';

final nameProvider = Provider<String>((ref) {
  return AuthService.instance.user.displayName ?? "";
});

final categoryProvider = Provider<List<JobCategory>>((ref) {
  return jobCategories;
});

final userDataStatusProvider = Provider<SubmitStatus>((ref) {
  final submitted = ref.watch(authProvider.notifier).submitted;
  print("In provider submitted is $submitted");
  return submitted;
});

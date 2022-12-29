import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/models/job_category.dart';
import 'package:handees/customer_app/services/auth_service.dart';

final nameProvider = Provider<String>((ref) {
  return AuthService.instance.user.displayName!;
});

final categoryProvider = Provider<List<JobCategory>>((ref) {
  return jobCategories;
});

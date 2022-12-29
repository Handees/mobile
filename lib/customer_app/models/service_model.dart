import 'package:handees/customer_app/models/job_category.dart';

class ServiceModel {
  final JobCategory serviceType;

  Stream<int> get distance async* {
    int i = 1000;
    while (true) {
      await Future.delayed(Duration(milliseconds: 10));
      yield --i;
      if (i == 0) break;
    }
  }

  ServiceModel({required this.serviceType});
}

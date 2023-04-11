import 'package:flutter/foundation.dart';
import 'package:handees/data/handees/job_category.dart';

class HomeViewModel extends ChangeNotifier {
  String get name => throw UnimplementedError();

  List get ongoingHandee => throw UnimplementedError();

  List<JobCategory> get categories => jobCategories;
}

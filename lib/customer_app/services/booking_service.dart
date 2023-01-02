import 'package:flutter/cupertino.dart';
import 'package:handees/customer_app/models/service_model.dart';
import 'package:handees/customer_app/models/job_category.dart';

class BookingService {
  BookingService._();
  static final BookingService _instance = BookingService._();
  static BookingService get instance => _instance;

  // TODO: implement activeServices
  Stream<List<ServiceModel>> get activeServices => throw UnimplementedError();

  Future<bool> bookService(JobCategory category) async {
    return false;
  }
}

class BookingServiceTest extends BookingService {
  BookingServiceTest._() : super._();
  static final BookingServiceTest _instance = BookingServiceTest._();
  static BookingServiceTest get instance => _instance;

  @override
  Stream<List<ServiceModel>> get activeServices async* {
    yield [
      // ServiceModel(serviceType: ServiceTypes.laundry),
    ];
  }

  @override
  Future<bool> bookService(JobCategory category) async {
    await Future.delayed(const Duration(seconds: 2));
    return DateTime.now().millisecond % 2 == 0 ? true : false;
  }
}

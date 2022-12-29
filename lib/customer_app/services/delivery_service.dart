import 'package:flutter/cupertino.dart';
import 'package:handees/customer_app/models/service_model.dart';
import 'package:handees/customer_app/models/job_category.dart';

class DeliveryService extends IDeliveryService {
  DeliveryService._();
  static final DeliveryService _instance = DeliveryService._();
  static DeliveryService get instance => _instance;

  @override
  // TODO: implement activeServices
  Stream<List<ServiceModel>> get activeServices => throw UnimplementedError();
}

class DeliveryServiceTest extends IDeliveryService {
  DeliveryServiceTest._();
  static final DeliveryServiceTest _instance = DeliveryServiceTest._();
  static DeliveryServiceTest get instance => _instance;

  @override
  Stream<List<ServiceModel>> get activeServices async* {
    yield [
      // ServiceModel(serviceType: ServiceTypes.laundry),
    ];
  }
}

abstract class IDeliveryService {
  Stream<List<ServiceModel>> get activeServices;
}

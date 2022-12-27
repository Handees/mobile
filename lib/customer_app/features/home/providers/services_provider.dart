import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/models/service_model.dart';
import 'package:handees/customer_app/services/delivery_service.dart';

final serviceProvider = StateNotifierProvider<ServiceNotifier, bool>((ref) {
  return ServiceNotifier();
});

class ServiceNotifier extends StateNotifier<bool> {
  ServiceNotifier() : super(true) {
    getServices();
  }

  void getServices() {
    deliveryService.activeServices.listen((event) {
      ongoingServices = event;
      state = false;
    });
  }

  final IDeliveryService deliveryService = DeliveryServiceTest.instance;

  List<ServiceModel>? ongoingServices;
}

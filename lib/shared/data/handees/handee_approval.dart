import 'package:handees/shared/data/handees/handee_options.dart';

class HandeeApproval {
  final String bookingId;
  final String workDurationType;
  final Settlement settlement;
  final int? duration;
  final String? durationUnit;

  HandeeApproval(
      {required this.bookingId,
      required this.workDurationType,
      required this.settlement,
      this.duration,
      this.durationUnit});

  HandeeApproval.empty({String? bookingId})
      : bookingId = bookingId ?? '',
        workDurationType = '',
        settlement = Settlement.empty(),
        duration = 0,
        durationUnit = '';

  HandeeApproval copywith(
      {String? bookingId,
      String? workDurationType,
      String? settlementPaymentType,
      double? settlementAmount,
      int? duration,
      String? durationUnit}) {
    return HandeeApproval(
      bookingId: bookingId ?? this.bookingId,
      workDurationType: workDurationType ?? this.workDurationType,
      settlement: settlement.copyWith(
          paymentType: settlementPaymentType ?? settlement.paymentType,
          amount: settlementAmount ?? settlement.amount),
      duration: duration ?? this.duration,
      durationUnit: durationUnit ?? this.durationUnit,
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      "booking_id": bookingId,
      "is_contract": workDurationType == WorkDurationTypes.contract,
      "settlement": settlement.toJson()
    };

    if (json['is_contract'] == true) {
      if (duration == null) {
        throw 'Duration can not be null when handee is a contract';
      }
      json['duration'] = duration!;
      if (durationUnit == null) {
        throw 'Duration Unit can not be null when handee is a contract';
      }
      json['duration_unit'] = durationUnit!;
    }

    return json;
  }
}

class Settlement {
  final String paymentType;
  final double amount;

  Settlement({required this.paymentType, required this.amount});

  Settlement.empty()
      : paymentType = '',
        amount = 0;

  Settlement copyWith({String? paymentType, double? amount}) {
    return Settlement(
      paymentType: paymentType ?? this.paymentType,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {"type": paymentOptionTypeToAPI[paymentType], "amount": amount};
  }
}

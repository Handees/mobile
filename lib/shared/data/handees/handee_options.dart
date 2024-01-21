abstract class WorkDurationTypes {
  static const String oneTime = 'One-time';
  static const String contract = 'Contract';
}

abstract class PaymentOptionTypes {
  static const hourly = 'Hourly Wage';
  static const negotiated = "Negotiated Wage";
}

Map<String, String> paymentOptionTypeToAPI = {
  PaymentOptionTypes.hourly: "hourly",
  PaymentOptionTypes.negotiated: "negotiation"
};

abstract class HandeeOptionTypes {
  static const workDuration = 'work-duration';
  static const paymentOption = 'payment-option';
}

abstract class DurationUnits {
  static const String days = 'days';
  static const String weeks = 'weeks';
}

class HandeeOption {
  final String title;
  final String description;

  HandeeOption({required this.title, required this.description});
}

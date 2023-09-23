class Handee {
  final String customerName;
  final int rating;
  final bool isCompleted;
  final DateTime date;

  Handee(
      {required this.customerName,
      required this.rating,
      required this.isCompleted,
      required this.date});

  Handee.empty()
      : customerName = '',
        rating = 0,
        isCompleted = false,
        date = DateTime.now();
}

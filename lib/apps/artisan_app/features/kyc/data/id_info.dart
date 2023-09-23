class IdInfo {
  final String imageUrl;
  final DateTime dateOfBirth;
  final String nin;
  final String frscNo;
  final String lastName;
  final String passportNo;

  IdInfo({
    required this.imageUrl,
    required this.dateOfBirth,
    required this.nin,
    required this.frscNo,
    required this.lastName,
    required this.passportNo,
  });

  IdInfo.empty()
      : imageUrl = '',
        dateOfBirth = DateTime.now(),
        nin = '',
        frscNo = '',
        lastName = '',
        passportNo = '';

  IdInfo copyWith({
    String? imageUrl,
    DateTime? dateOfBirth,
    String? nin,
    String? frscNo,
    String? lastName,
    String? passportNo,
  }) {
    return IdInfo(
      imageUrl: imageUrl ?? this.imageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nin: nin ?? this.nin,
      frscNo: frscNo ?? this.frscNo,
      lastName: lastName ?? this.lastName,
      passportNo: passportNo ?? this.passportNo,
    );
  }
}

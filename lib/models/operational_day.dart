// --- Model Data Jam Operasional ---
class OperationalDay {
  final String day;
  final bool isActive;
  final String openTime;
  final String closeTime;

  OperationalDay({
    required this.day,
    required this.isActive,
    required this.openTime,
    required this.closeTime,
  });

  OperationalDay copyWith({
    bool? isActive,
    String? openTime,
    String? closeTime,
  }) {
    return OperationalDay(
      day: day,
      isActive: isActive ?? this.isActive,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }
}

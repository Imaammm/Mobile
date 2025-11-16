// --- Model Data Pesanan ---
class OrderItem {
  final String name;
  final DateTime date;
  final String time;
  final String courts;
  final String bookingId;
  final int amount;
  final String status;

  OrderItem({
    required this.name,
    required this.date,
    required this.time,
    required this.courts,
    required this.bookingId,
    required this.amount,
    required this.status,
  });
}

// --- Model Data Booking Aktif (Mirip dengan OrderItem, tapi fokus pada status aktif) ---
class BookingItem {
  final String id;
  final String name;
  final DateTime date;
  final String timeSlots; // Cth: 06:00-07:00 & 07:00-08:00
  final String court;
  final int amount;
  final String status; // 'Confirmed', 'Rescheduled', 'Cancelled'

  BookingItem({
    required this.id,
    required this.name,
    required this.date,
    required this.timeSlots,
    required this.court,
    required this.amount,
    required this.status,
  });
}

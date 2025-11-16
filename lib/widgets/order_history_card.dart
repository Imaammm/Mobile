import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart';
import 'status_chip.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderItem order;
  final bool isSelected;
  final ValueChanged<bool?> onSelect;
  final String Function(int) formatRupiah;

  const OrderHistoryCard({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onSelect,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: isSelected, onChanged: onSelect),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Status Chip
                        StatusChip(status: order.status),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Detail Booking
                    Text(
                      // Format Tanggal menggunakan locale id_ID (yang memicu error Anda)
                      '${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(order.date)}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.time,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.person, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Lapangan: ${order.courts}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // ID dan Harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.bookingId,
                          style: const TextStyle(color: Colors.blue),
                        ),
                        Text(
                          formatRupiah(order.amount),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

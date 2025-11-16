import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilterSection extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onStartDateTap;
  final VoidCallback onEndDateTap;
  final VoidCallback onFilterPressed;

  const DateFilterSection({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateTap,
    required this.onEndDateTap,
    required this.onFilterPressed,
  });

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    final dateString = date != null
        ? DateFormat('dd/MM/yyyy').format(date)
        : 'dd/mm/yyyy';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateString,
                  style: TextStyle(
                    color: date != null ? Colors.black87 : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_month),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Periode',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Input Tanggal Mulai
          _buildDateField('Dari Tanggal', startDate, onStartDateTap),
          const SizedBox(height: 10),
          // Input Tanggal Akhir
          _buildDateField('Sampai Tanggal', endDate, onEndDateTap),
          const SizedBox(height: 15),
          // Tombol Filter
          ElevatedButton(
            onPressed: onFilterPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Filter'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

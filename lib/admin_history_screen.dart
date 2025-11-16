import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/order_item.dart';
import 'widgets/date_filter_section.dart';
import 'widgets/order_history_card.dart';

// --- Admin History Screen (Stateful Widget) ---
class AdminHistoryScreen extends StatefulWidget {
  const AdminHistoryScreen({super.key});

  @override
  State<AdminHistoryScreen> createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {
  // State untuk Filter Periode
  DateTime? _startDate;
  DateTime? _endDate;
  bool _selectAll = false;

  // Mock data pesanan (mereplikasi data dari Next.js)
  final List<OrderItem> _allOrders = [
    OrderItem(
      name: 'Eqi',
      date: DateTime(2025, 11, 9),
      time: '06:00 - 08:00',
      courts: 'Lapangan 1, Lapangan 2',
      bookingId: '#WEB-JLOZqEEZgL',
      amount: 340000,
      status: 'Pending',
    ),
    OrderItem(
      name: 'Ayari Tenri beta',
      date: DateTime(2110, 12, 8),
      time: '06:00 - 08:00',
      courts: 'Lapangan 2',
      bookingId: '#WEB-I3lVk_btql',
      amount: 170000,
      status: 'Pending',
    ),
    // Tambahkan 14 data lainnya untuk mencukupi jumlah (16)
    ...List.generate(
      14,
      (index) => OrderItem(
        name: 'Pesanan #${index + 3}',
        date: DateTime(2025, 10, 20 + index),
        time: '10:00 - 11:00',
        courts: 'Lapangan 1',
        bookingId: '#WEB-${index + 3}',
        amount: 85000,
        status: index.isEven ? 'Confirmed' : 'Cancelled',
      ),
    ),
  ];

  // State untuk menyimpan status checkbox setiap item
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<bool>.filled(_allOrders.length, false);
  }

  // LOGIKA: Fungsi untuk menampilkan Date Picker
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2110),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  // LOGIKA: Fungsi saat Checkbox "Pilih Semua" diklik
  void _toggleSelectAll(bool? value) {
    if (value != null) {
      setState(() {
        _selectAll = value;
        _selectedItems = List<bool>.filled(_allOrders.length, value);
      });
    }
  }

  // LOGIKA: Fungsi saat Checkbox item individual diklik
  void _toggleItemSelection(int index, bool? value) {
    if (value != null) {
      setState(() {
        _selectedItems[index] = value;
        if (!value) {
          _selectAll = false;
        } else if (_selectedItems.every((element) => element)) {
          _selectAll = true;
        }
      });
    }
  }

  // LOGIKA: Fungsi Export
  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mengekspor 16 data pesanan...')),
    );
  }

  // Fungsi untuk format Rupiah sederhana
  String _formatRupiah(int amount) {
    // Menggunakan NumberFormat untuk format Rupiah yang benar
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount).replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    final int selectedCount = _selectedItems.where((element) => element).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrasi'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      // MENGHILANGKAN AdminDrawerPlaceholder dan menggantinya dengan Drawer aslinya
      // Asumsi AdminDrawer sudah tersedia via import di file lain atau di sini.
      // Jika AdminDrawer tidak tersedia di sini, Anda harus memasukkannya.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Pesanan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Tombol Export
                ElevatedButton.icon(
                  onPressed: _exportData,
                  icon: const Icon(Icons.download, size: 18),
                  label: Text('Export (${_allOrders.length})'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- FILTER PERIODE ---
          DateFilterSection(
            startDate: _startDate,
            endDate: _endDate,
            onStartDateTap: () => _selectDate(context, true),
            onEndDateTap: () => _selectDate(context, false),
            onFilterPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menerapkan filter...')),
              );
            },
          ),

          // --- PILIH SEMUA & DAFTAR PESANAN ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Checkbox(value: _selectAll, onChanged: _toggleSelectAll),
                Text('Pilih Semua (${_allOrders.length})'),
                if (selectedCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '($selectedCount dipilih)',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _allOrders.length,
              itemBuilder: (context, index) {
                final order = _allOrders[index];
                final isSelected = _selectedItems[index];

                return OrderHistoryCard(
                  order: order,
                  isSelected: isSelected,
                  onSelect: (value) => _toggleItemSelection(index, value),
                  formatRupiah: _formatRupiah,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Komponen widget sudah dipindahkan ke file terpisah ---

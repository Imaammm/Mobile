import 'package:flutter/material.dart';
// --- IMPORT SEMUA FILE ADMIN UNTUK NAVIGASI ---
import 'admin_account_screen.dart'; // Untuk Manajemen Akun
import 'admin_carousel_management_screen.dart'; // Untuk Pengaturan Carousel
import 'admin_operational_screen.dart'; // Untuk Jam Operasional
import 'admin_price_and_payment_screen.dart'; // Untuk Tarif & Pembayaran
import 'widgets/admin_drawer.dart';
import 'widgets/admin_menu_item_card.dart';

// --- Admin Home Screen (Stateless Widget) ---
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  // Fungsi navigasi yang bersih
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrasi'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manajemen Aplikasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Pilih kategori di bawah ini untuk mengelola konfigurasi sistem Tennis Court Anda.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),

            // --- Menu Item Cards ---
            AdminMenuItemCard(
              icon: Icons.manage_accounts, // Mengubah ikon settings lama
              iconColor: Colors.teal,
              title: 'Manajemen Akun',
              subtitle: 'Kelola kata sandi, email, dan detail akun Admin Anda.',
              onTap: () => _navigateTo(
                context,
                const AdminAccountScreen(),
              ), // Navigasi Bekerja
            ),
            AdminMenuItemCard(
              icon: Icons.payments,
              iconColor: Colors.amber,
              title: 'Tarif & Pembayaran',
              subtitle:
                  'Atur harga sewa per jam dan konfigurasi metode pembayaran.',
              onTap: () => _navigateTo(
                context,
                const AdminPriceAndPaymentScreen(),
              ), // Navigasi Bekerja
            ),
            AdminMenuItemCard(
              icon: Icons.schedule,
              iconColor: Colors.redAccent,
              title: 'Jam Operasional',
              subtitle: 'Tentukan jam buka dan tutup harian Lapangan Tenis.',
              onTap: () => _navigateTo(
                context,
                const AdminOperationalScreen(),
              ), // Navigasi Bekerja
            ),
            AdminMenuItemCard(
              icon: Icons.image,
              iconColor: Colors.blue,
              title: 'Pengaturan Carousel',
              subtitle:
                  'Tambah, hapus, atau atur urutan gambar di halaman utama (carousel).',
              onTap: () => _navigateTo(
                context,
                const AdminCarouselScreen(),
              ), // Navigasi Bekerja
            ),

            const SizedBox(height: 30),

            // --- TOMBOL KEMBALI KE APLIKASI USER ---
            ElevatedButton.icon(
              onPressed: () {
                // popUntil kembali ke root screen (MainScreen)
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text(
                'Kembali ke Halaman Booking',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade600,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

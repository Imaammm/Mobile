import 'package:flutter/material.dart';

import '../admin_home_screen.dart';
import '../admin_manual_booking_screen.dart';
import '../admin_schedule_management.dart';
import '../admin_history_screen.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  void _navigateToAndPopDrawer(BuildContext context, Widget screen) {
    Navigator.pop(context); // Tutup drawer terlebih dahulu
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // Menggunakan Column agar bisa menggunakan Spacer
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tennis Court.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // --- ITEM NAVIGASI DRAWER ---
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home Page (Admin)',
            onTap: () =>
                _navigateToAndPopDrawer(context, const AdminHomeScreen()),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.book_online,
            title: 'Booking Manual',
            onTap: () => _navigateToAndPopDrawer(
              context,
              const AdminManualBookingScreen(),
            ), // Navigasi Bekerja
          ),
          _buildDrawerItem(
            context,
            icon: Icons.calendar_today,
            title: 'Kelola Jadwal',
            onTap: () => _navigateToAndPopDrawer(
              context,
              const AdminScheduleManagementScreen(),
            ), // Navigasi Bekerja
          ),
          _buildDrawerItem(
            context,
            icon: Icons.history,
            title: 'Riwayat Pesanan',
            onTap: () =>
                _navigateToAndPopDrawer(context, const AdminHistoryScreen()),
          ),

          const Divider(),

          // --- TOMBOL LOGOUT (placeholder) ---
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout (Placeholder)')),
              );
            },
          ),

          const Spacer(),

          // --- FOOTER DRAWER ---
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tennis Court Admin v1.0',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '© 2025 All Rights Reserved.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

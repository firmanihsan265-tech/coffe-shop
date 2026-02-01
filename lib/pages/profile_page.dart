import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'login_page.dart';
import 'favorite_page.dart';
import 'order_history_page.dart';
import 'payment_methods_page.dart';
import 'address_management_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    void _logout() {
      appState.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    void _navigateToFavorites() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoritePage()),
      );
    }

    void _navigateToOrderHistory() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderHistoryPage()),
      );
    }

    void _navigateToPaymentMethods() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
      );
    }

    void _navigateToAddressManagement() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddressManagementPage()),
      );
    }

    void _showAboutDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFC67C4E),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.coffee,
                        color: Colors.white,
                        size: 20,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text('Tentang Aplikasi'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coffee Shop App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC67C4E),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Versi 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Dibuat oleh:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('• Elvando'),
              Text('• Fabiano'),
              Text('• Faris'),
              Text('• Ficke'),
              Text('• Fiola'),
              Text('• Firman'),
              SizedBox(height: 16),
              Text(
                'Aplikasi coffee shop dengan fitur lengkap untuk pemesanan kopi online.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFC67C4E),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person, size: 50, color: Colors.white);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      appState.userName.isNotEmpty 
                          ? appState.userName 
                          : 'Pecinta Kopi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      appState.userEmail.isNotEmpty 
                          ? appState.userEmail 
                          : 'pecinta.kopi@email.com',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('Pesanan', appState.orders.length.toString()),
                        _buildStatItem('Poin', '1,234'),
                        _buildStatItem('Member', 'Gold'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Menu Items
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    icon: Icons.history,
                    title: 'Riwayat Pesanan',
                    subtitle: 'Lihat pesanan Anda sebelumnya',
                    onTap: _navigateToOrderHistory,
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.favorite,
                    title: 'Kopi Favorit',
                    subtitle: 'Kopi yang Anda sukai',
                    onTap: _navigateToFavorites,
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.location_on,
                    title: 'Alamat Pengiriman',
                    subtitle: 'Kelola alamat Anda',
                    onTap: _navigateToAddressManagement,
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.payment,
                    title: 'Metode Pembayaran',
                    subtitle: 'Tambah atau hapus kartu pembayaran',
                    onTap: _navigateToPaymentMethods,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Settings Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    icon: Icons.settings,
                    title: 'Pengaturan',
                    subtitle: 'Preferensi dan konfigurasi aplikasi',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pengaturan akan segera hadir!')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.help,
                    title: 'Bantuan & Dukungan',
                    subtitle: 'Dapatkan bantuan dan hubungi dukungan',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bantuan & Dukungan akan segera hadir!')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.info,
                    title: 'Tentang',
                    subtitle: 'Versi aplikasi dan informasi',
                    onTap: _showAboutDialog,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC67C4E),
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFC67C4E).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Color(0xFFC67C4E)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1),
    );
  }
}
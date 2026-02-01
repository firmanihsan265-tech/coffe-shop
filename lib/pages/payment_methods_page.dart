import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final selectedMethod = appState.selectedPaymentMethod;

    return Scaffold(
      appBar: AppBar(
        title: Text('Metode Pembayaran'),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Metode Pembayaran Default',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ini akan menjadi metode pembayaran default untuk pesanan mendatang',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            _buildPaymentOption(
              context,
              "Cash on Delivery", 
              "cash", 
              Icons.money, 
              "Bayar saat pesanan diterima",
              selectedMethod,
            ),
            _buildPaymentOption(
              context,
              "QRIS", 
              "qris", 
              Icons.qr_code, 
              "Scan QR code untuk pembayaran",
              selectedMethod,
            ),
            _buildPaymentOption(
              context,
              "GoPay", 
              "gopay", 
              Icons.account_balance_wallet, 
              "Link dengan GoPay",
              selectedMethod,
            ),
            _buildPaymentOption(
              context,
              "OVO", 
              "ovo", 
              Icons.credit_card, 
              "Bayar dengan OVO",
              selectedMethod,
            ),
            _buildPaymentOption(
              context,
              "Bank Transfer", 
              "bank", 
              Icons.account_balance, 
              "Transfer bank manual",
              selectedMethod,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String title, 
    String value, 
    IconData icon, 
    String description,
    String selectedMethod,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFC67C4E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFFC67C4E)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Radio<String>(
          value: value,
          groupValue: selectedMethod,
          onChanged: (val) {
            final appState = Provider.of<AppState>(context, listen: false);
            appState.setPaymentMethod(val!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title diatur sebagai metode pembayaran default'),
                backgroundColor: Color(0xFFC67C4E),
                duration: Duration(seconds: 2),
              ),
            );
          },
          activeColor: Color(0xFFC67C4E),
        ),
        onTap: () {
          final appState = Provider.of<AppState>(context, listen: false);
          appState.setPaymentMethod(value);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title diatur sebagai metode pembayaran default'),
              backgroundColor: Color(0xFFC67C4E),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
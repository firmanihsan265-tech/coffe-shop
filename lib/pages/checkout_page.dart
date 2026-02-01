import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'address_management_page.dart';

class CheckoutPage extends StatefulWidget {
  final double totalAmount;

  const CheckoutPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'cash';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    selectedPayment = appState.selectedPaymentMethod;
  }

  void _showAddressDialog() {
    final appState = Provider.of<AppState>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Alamat Pengiriman'),
        content: appState.addresses.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_off, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Belum ada alamat tersimpan'),
                ],
              )
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: appState.addresses.length,
                  itemBuilder: (context, index) {
                    final address = appState.addresses[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: appState.selectedAddress?.id == address.id 
                          ? Color(0xFFC67C4E).withOpacity(0.1) 
                          : null,
                      child: ListTile(
                        leading: Icon(Icons.location_on, color: Color(0xFFC67C4E)),
                        title: Text(address.name),
                        subtitle: Text(address.fullAddress),
                        trailing: appState.selectedAddress?.id == address.id
                            ? Icon(Icons.check, color: Color(0xFFC67C4E))
                            : null,
                        onTap: () {
                          appState.setSelectedAddress(address.id);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToAddressManagement();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC67C4E),
            ),
            child: Text('Kelola Alamat'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddressManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressManagementPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Alamat Pengiriman
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Alamat Pengiriman",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[800],
                                  ),
                                ),
                                TextButton(
                                  onPressed: _showAddressDialog,
                                  child: Text('Ubah'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            if (appState.selectedAddress != null) ...[
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Color(0xFFC67C4E)),
                                  SizedBox(width: 8),
                                  Text(
                                    appState.selectedAddress!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(appState.selectedAddress!.fullAddress),
                              SizedBox(height: 4),
                              Text('Telp: ${appState.selectedAddress!.phone}'),
                            ] else ...[
                              Row(
                                children: [
                                  Icon(Icons.warning, size: 16, color: Colors.orange),
                                  SizedBox(width: 8),
                                  Text('Belum ada alamat terpilih'),
                                ],
                              ),
                              SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: _navigateToAddressManagement,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFC67C4E),
                                ),
                                child: Text('Tambah Alamat'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Order Summary
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ringkasan Pesanan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[800],
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Pembayaran",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Rp ${(widget.totalAmount * 15000).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC67C4E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Payment Methods
                    Text(
                      "Pilih Metode Pembayaran", 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      )
                    ),
                    SizedBox(height: 16),
                    
                    _buildPaymentOption("Cash on Delivery", "cash", Icons.money, "Bayar saat pesanan diterima"),
                    _buildPaymentOption("QRIS", "qris", Icons.qr_code, "Scan QR code untuk pembayaran"),
                    _buildPaymentOption("GoPay", "gopay", Icons.account_balance_wallet, "Link dengan GoPay"),
                    _buildPaymentOption("OVO", "ovo", Icons.credit_card, "Bayar dengan OVO"),
                    _buildPaymentOption("Bank Transfer", "bank", Icons.account_balance, "Transfer bank manual"),
                    
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Pay Button - Fixed at bottom
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: _isProcessing
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC67C4E)),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: appState.selectedAddress != null ? _processOrder : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appState.selectedAddress != null 
                              ? Color(0xFFC67C4E) 
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Bayar Sekarang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value, IconData icon, String description) {
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
          groupValue: selectedPayment,
          onChanged: (val) => setState(() => selectedPayment = val!),
          activeColor: Color(0xFFC67C4E),
        ),
        onTap: () => setState(() => selectedPayment = value),
      ),
    );
  }

  void _processOrder() async {
    if (_isProcessing) return;
    
    setState(() {
      _isProcessing = true;
    });

    await Future.delayed(Duration(seconds: 2));

    final appState = Provider.of<AppState>(context, listen: false);
    
    appState.addOrder(
      appState.cartItems, 
      widget.totalAmount, 
      selectedPayment,
      'M',
      deliveryAddress: appState.selectedAddress
    );
    
    appState.setPaymentMethod(selectedPayment);
    appState.clearCart();

    setState(() {
      _isProcessing = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    final appState = Provider.of<AppState>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 24),
              SizedBox(width: 8),
              Text("Pembayaran Berhasil"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pesanan Anda telah berhasil diproses!"),
              SizedBox(height: 8),
              Text(
                "Metode Pembayaran: ${_getPaymentMethodName(selectedPayment)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC67C4E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Total: Rp ${(widget.totalAmount * 15000).toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (appState.selectedAddress != null) ...[
                SizedBox(height: 8),
                Divider(),
                Text(
                  "Alamat Pengiriman:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(appState.selectedAddress!.name),
                Text(appState.selectedAddress!.fullAddress),
                Text('Telp: ${appState.selectedAddress!.phone}'),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Kembali ke Home"),
            ),
          ],
        );
      }, 
    );
  }

  String _getPaymentMethodName(String method) {
    switch (method) {
      case 'cash': return 'Cash on Delivery';
      case 'qris': return 'QRIS';
      case 'gopay': return 'GoPay';
      case 'ovo': return 'OVO';
      case 'bank': return 'Bank Transfer';
      default: return 'Tidak Diketahui';
    }
  }
}
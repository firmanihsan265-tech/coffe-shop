import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  final VoidCallback? onNavigateToHome;

  const CartPage({Key? key, this.onNavigateToHome}) : super(key: key);

  void _backToHome(BuildContext context) {
    if (onNavigateToHome != null) {
      onNavigateToHome!();
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _navigateToCheckout(BuildContext context, double totalAmount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(totalAmount: totalAmount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final cartItems = appState.cartItems;
    final totalPrice = appState.cartTotalPrice;

    void _updateQuantity(String coffeeId, int newQuantity) {
      appState.updateCartQuantity(coffeeId, newQuantity);
    }

    void _removeItem(String coffeeId) {
      appState.removeFromCart(coffeeId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Saya'),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
                  SizedBox(height: 20),
                  Text(
                    'Keranjang Anda kosong',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _backToHome(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC67C4E),
                    ),
                    child: Text('Lanjutkan Belanja'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(item.coffee.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(item.coffee.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.coffee.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rp ${(item.coffee.price * 15000).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFC67C4E),
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, size: 20),
                                onPressed: () {
                                  _updateQuantity(item.coffee.id, item.quantity - 1);
                                },
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, size: 20),
                                onPressed: () {
                                  _updateQuantity(item.coffee.id, item.quantity + 1);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () => _removeItem(item.coffee.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Total and Checkout Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp ${(totalPrice * 15000).toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC67C4E),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _navigateToCheckout(context, totalPrice),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC67C4E),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _backToHome(context),
                        child: Text('Kembali ke Toko'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
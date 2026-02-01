import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/coffee.dart';

class DetailPage extends StatefulWidget {
  final Coffee coffee;

  const DetailPage({Key? key, required this.coffee}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _selectedSize = 'M';
  Map<String, double> _sizePrices = {
    'S': -0.5,
    'M': 0.0,
    'L': 0.8,
  };

  double get _currentPrice {
    return widget.coffee.price + _sizePrices[_selectedSize]!;
  }

  void _addToCart(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    
    final coffeeWithSize = Coffee(
      id: '${widget.coffee.id}_$_selectedSize',
      name: '${widget.coffee.name} ($_selectedSize)',
      description: widget.coffee.description,
      price: _currentPrice,
      imageUrl: widget.coffee.imageUrl,
      category: widget.coffee.category,
      rating: widget.coffee.rating,
      isFavorite: widget.coffee.isFavorite,
    );

    appState.addToCart(coffeeWithSize);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${coffeeWithSize.name} ditambahkan ke keranjang!'),
        backgroundColor: Color(0xFFC67C4E),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kopi'),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coffee Image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.coffee.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.coffee, size: 80, color: Color(0xFFC67C4E)),
                            SizedBox(height: 10),
                            Text(
                              widget.coffee.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC67C4E),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Coffee Name
              Text(
                widget.coffee.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
              SizedBox(height: 10),
              
              // Description
              Text(
                widget.coffee.description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              
              // Rating
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFC67C4E), size: 24),
                  SizedBox(width: 5),
                  Text(
                    '${widget.coffee.rating}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '(230 Ulasan)',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Size Selection
              Text(
                'Ukuran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildSizeOption('S', _selectedSize == 'S'),
                  SizedBox(width: 10),
                  _buildSizeOption('M', _selectedSize == 'M'),
                  SizedBox(width: 10),
                  _buildSizeOption('L', _selectedSize == 'L'),
                ],
              ),
              SizedBox(height: 30),
              
              // Price and Buy Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harga',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rp ${(_currentPrice * 15000).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC67C4E),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC67C4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Beli',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size, bool isSelected) {
    double priceAdjustment = _sizePrices[size]!;
    String priceText = priceAdjustment == 0 
        ? '' 
        : priceAdjustment > 0 
            ? '+Rp ${(priceAdjustment * 15000).toStringAsFixed(0)}'
            : '-Rp ${(priceAdjustment.abs() * 15000).toStringAsFixed(0)}';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFC67C4E) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFFC67C4E) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              size,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (priceText.isNotEmpty)
              Text(
                priceText,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[500],
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
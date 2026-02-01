import 'package:flutter/foundation.dart';
import 'coffee.dart';
import 'address.dart'; // TAMBAHKAN IMPORT
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppState with ChangeNotifier {
  List<Coffee> _allCoffees = [
    // Cappuccino (12 produk) - TETAP SAMA
    Coffee(
      id: '1',
      name: 'Classic Cappuccino',
      description: 'With Oat Milk',
      price: 4.20,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.8,
    ),
    Coffee(
      id: '2',
      name: 'Vanilla Cappuccino',
      description: 'Sweet vanilla flavor',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.6,
    ),
    Coffee(
      id: '3',
      name: 'Caramel Cappuccino',
      description: 'Rich caramel drizzle',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.9,
    ),
    Coffee(
      id: '4',
      name: 'Hazelnut Cappuccino',
      description: 'Nutty hazelnut aroma',
      price: 4.60,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.5,
    ),
    Coffee(
      id: '5',
      name: 'Cinnamon Cappuccino',
      description: 'Warm cinnamon spice',
      price: 4.40,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.7,
    ),
    Coffee(
      id: '6',
      name: 'Coconut Cappuccino',
      description: 'Tropical coconut twist',
      price: 4.70,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.4,
    ),
    Coffee(
      id: '7',
      name: 'Mocha Cappuccino',
      description: 'Chocolate coffee blend',
      price: 5.00,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.8,
    ),
    Coffee(
      id: '8',
      name: 'Irish Cappuccino',
      description: 'Whiskey flavored',
      price: 5.20,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.6,
    ),
    Coffee(
      id: '9',
      name: 'Pumpkin Cappuccino',
      description: 'Seasonal pumpkin spice',
      price: 4.90,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.7,
    ),
    Coffee(
      id: '10',
      name: 'Almond Cappuccino',
      description: 'Creamy almond milk',
      price: 4.60,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.5,
    ),
    Coffee(
      id: '11',
      name: 'Maple Cappuccino',
      description: 'Canadian maple syrup',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.6,
    ),
    Coffee(
      id: '12',
      name: 'Orange Cappuccino',
      description: 'Citrus orange zest',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Cappuccino',
      rating: 4.3,
    ),

    // Latte (12 produk) - TETAP SAMA
    Coffee(
      id: '13',
      name: 'Classic Latte',
      description: 'With Chocolate',
      price: 3.50,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.5,
    ),
    Coffee(
      id: '14',
      name: 'Caramel Latte',
      description: 'Sweet caramel swirl',
      price: 4.00,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.7,
    ),
    Coffee(
      id: '15',
      name: 'Vanilla Latte',
      description: 'Smooth vanilla',
      price: 3.80,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.6,
    ),
    Coffee(
      id: '16',
      name: 'Hazelnut Latte',
      description: 'Rich hazelnut',
      price: 4.10,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.4,
    ),
    Coffee(
      id: '17',
      name: 'Matcha Latte',
      description: 'Green tea flavor',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.8,
    ),
    Coffee(
      id: '18',
      name: 'Turmeric Latte',
      description: 'Golden milk latte',
      price: 4.20,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.3,
    ),
    Coffee(
      id: '19',
      name: 'Coconut Latte',
      description: 'Tropical coconut',
      price: 4.30,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.5,
    ),
    Coffee(
      id: '20',
      name: 'Lavender Latte',
      description: 'Floral lavender',
      price: 4.60,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.7,
    ),
    Coffee(
      id: '21',
      name: 'Rose Latte',
      description: 'Elegant rose flavor',
      price: 4.70,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.6,
    ),
    Coffee(
      id: '22',
      name: 'Pistachio Latte',
      description: 'Nutty pistachio',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.9,
    ),
    Coffee(
      id: '23',
      name: 'Almond Latte',
      description: 'Toasted almond',
      price: 4.10,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.4,
    ),
    Coffee(
      id: '24',
      name: 'Cinnamon Latte',
      description: 'Spiced cinnamon',
      price: 3.90,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Latte',
      rating: 4.5,
    ),

    // Espresso (12 produk) - TETAP SAMA
    Coffee(
      id: '25',
      name: 'Classic Espresso',
      description: 'Strong and Bold',
      price: 2.80,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.7,
    ),
    Coffee(
      id: '26',
      name: 'Double Espresso',
      description: 'Extra strong shot',
      price: 3.50,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.8,
    ),
    Coffee(
      id: '27',
      name: 'Ristretto',
      description: 'Short pulled espresso',
      price: 3.20,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.6,
    ),
    Coffee(
      id: '28',
      name: 'Lungo',
      description: 'Long pulled espresso',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.5,
    ),
    Coffee(
      id: '29',
      name: 'Macchiato',
      description: 'Espresso with foam',
      price: 3.30,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.7,
    ),
    Coffee(
      id: '30',
      name: 'Corretto',
      description: 'Espresso with liquor',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.4,
    ),
    Coffee(
      id: '31',
      name: 'Romano',
      description: 'Espresso with lemon',
      price: 3.40,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.2,
    ),
    Coffee(
      id: '32',
      name: 'Coretto',
      description: 'With grappa',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.6,
    ),
    Coffee(
      id: '33',
      name: 'Freddo',
      description: 'Iced espresso',
      price: 3.60,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.5,
    ),
    Coffee(
      id: '34',
      name: 'Caffe Americano',
      description: 'Espresso with water',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.3,
    ),
    Coffee(
      id: '35',
      name: 'Cubano',
      description: 'Sweet Cuban style',
      price: 3.70,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.7,
    ),
    Coffee(
      id: '36',
      name: 'Doppio',
      description: 'Double shot',
      price: 3.50,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Espresso',
      rating: 4.8,
    ),

    // Americano (12 produk) - TETAP SAMA
    Coffee(
      id: '37',
      name: 'Classic Americano',
      description: 'Hot and Classic',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.3,
    ),
    Coffee(
      id: '38',
      name: 'Iced Americano',
      description: 'Chilled classic',
      price: 3.20,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.5,
    ),
    Coffee(
      id: '39',
      name: 'Long Black',
      description: 'Australian style',
      price: 3.40,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.4,
    ),
    Coffee(
      id: '40',
      name: 'Red Eye',
      description: 'Americano with drip',
      price: 3.80,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.6,
    ),
    Coffee(
      id: '41',
      name: 'Black Eye',
      description: 'Double red eye',
      price: 4.20,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.7,
    ),
    Coffee(
      id: '42',
      name: 'Dead Eye',
      description: 'Triple red eye',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.9,
    ),
    Coffee(
      id: '43',
      name: 'Lazy Eye',
      description: 'With decaf shot',
      price: 3.60,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.2,
    ),
    Coffee(
      id: '44',
      name: 'Green Eye',
      description: 'With matcha',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.5,
    ),
    Coffee(
      id: '45',
      name: 'Purple Eye',
      description: 'With lavender',
      price: 4.30,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.4,
    ),
    Coffee(
      id: '46',
      name: 'Caramel Americano',
      description: 'Sweet caramel',
      price: 3.90,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.6,
    ),
    Coffee(
      id: '47',
      name: 'Vanilla Americano',
      description: 'Smooth vanilla',
      price: 3.70,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.5,
    ),
    Coffee(
      id: '48',
      name: 'Hazelnut Americano',
      description: 'Nutty flavor',
      price: 3.80,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Americano',
      rating: 4.4,
    ),

    // Cold Brew (12 produk) - DITAMBAHKAN KEMBALI
    Coffee(
      id: '49',
      name: 'Classic Cold Brew',
      description: 'Smooth and chilled',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.7,
    ),
    Coffee(
      id: '50',
      name: 'Vanilla Cold Brew',
      description: 'Sweet vanilla',
      price: 5.00,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.8,
    ),
    Coffee(
      id: '51',
      name: 'Salted Caramel Cold Brew',
      description: 'Salty sweet',
      price: 5.20,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.9,
    ),
    Coffee(
      id: '52',
      name: 'Nitro Cold Brew',
      description: 'Creamy nitro',
      price: 5.50,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.8,
    ),
    Coffee(
      id: '53',
      name: 'Coconut Cold Brew',
      description: 'Tropical twist',
      price: 5.10,
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.6,
    ),
    Coffee(
      id: '54',
      name: 'Mocha Cold Brew',
      description: 'Chocolate coffee',
      price: 5.30,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.7,
    ),
    Coffee(
      id: '55',
      name: 'Honey Cold Brew',
      description: 'Natural sweetness',
      price: 4.90,
      imageUrl: 'https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.5,
    ),
    Coffee(
      id: '56',
      name: 'Cinnamon Cold Brew',
      description: 'Spiced flavor',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.4,
    ),
    Coffee(
      id: '57',
      name: 'Orange Cold Brew',
      description: 'Citrus notes',
      price: 5.00,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.3,
    ),
    Coffee(
      id: '58',
      name: 'Lavender Cold Brew',
      description: 'Floral aroma',
      price: 5.20,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.6,
    ),
    Coffee(
      id: '59',
      name: 'Pumpkin Cold Brew',
      description: 'Seasonal favorite',
      price: 5.40,
      imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.7,
    ),
    Coffee(
      id: '60',
      name: 'Almond Cold Brew',
      description: 'Nutty delight',
      price: 5.10,
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=400&h=300&fit=crop',
      category: 'Cold Brew',
      rating: 4.5,
    ),
  ];

  List<CartItem> _cartItems = [];
  List<Order> _orders = [];
  String _selectedPaymentMethod = 'cash';
  
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';

  // TAMBAHKAN: Fitur alamat
  List<Address> _addresses = [];
  Address? _selectedAddress;

  List<Coffee> get allCoffees => _allCoffees;
  List<Coffee> get favoriteCoffees => _allCoffees.where((coffee) => coffee.isFavorite).toList();
  List<CartItem> get cartItems => _cartItems;
  List<Order> get orders => _orders;
  double get cartTotalPrice => _cartItems.fold(0, (total, item) => total + (item.coffee.price * item.quantity));
  String get selectedPaymentMethod => _selectedPaymentMethod;
  
  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;
  String get userName => _userName;

  // TAMBAHKAN: Getter untuk alamat
  List<Address> get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress;

  AppState() {
    _loadOrders();
    _loadPaymentMethod();
    _loadAddresses(); // TAMBAHKAN: Load alamat
  }

  // TAMBAHKAN: Methods untuk mengelola alamat
  void addAddress(Address address) {
    _addresses.add(address);
    if (_addresses.length == 1 || address.isDefault) {
      _selectedAddress = address;
    }
    _saveAddresses();
    notifyListeners();
  }

  void updateAddress(String id, Address newAddress) {
    final index = _addresses.indexWhere((addr) => addr.id == id);
    if (index != -1) {
      _addresses[index] = newAddress;
      if (newAddress.isDefault) {
        _selectedAddress = newAddress;
      }
      _saveAddresses();
      notifyListeners();
    }
  }

  void removeAddress(String id) {
    _addresses.removeWhere((addr) => addr.id == id);
    if (_selectedAddress?.id == id) {
      _selectedAddress = _addresses.isNotEmpty ? _addresses.first : null;
    }
    _saveAddresses();
    notifyListeners();
  }

  void setSelectedAddress(String id) {
    final address = _addresses.firstWhere((addr) => addr.id == id);
    _selectedAddress = address;
    _saveSelectedAddress();
    notifyListeners();
  }

  // TAMBAHKAN: Load dan save addresses
  Future<void> _loadAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressesJson = prefs.getString('addresses');
      if (addressesJson != null) {
        final List<dynamic> addressesList = json.decode(addressesJson);
        _addresses = addressesList.map((addrJson) => Address.fromJson(addrJson)).toList();
        
        // Load selected address
        final selectedId = prefs.getString('selected_address_id');
        if (selectedId != null) {
          _selectedAddress = _addresses.firstWhere((addr) => addr.id == selectedId);
        } else if (_addresses.isNotEmpty) {
          _selectedAddress = _addresses.firstWhere((addr) => addr.isDefault, orElse: () => _addresses.first);
        }
      }
    } catch (e) {
      print('Error loading addresses: $e');
    }
  }

  Future<void> _saveAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressesJson = json.encode(_addresses.map((addr) => addr.toJson()).toList());
      await prefs.setString('addresses', addressesJson);
    } catch (e) {
      print('Error saving addresses: $e');
    }
  }

  Future<void> _saveSelectedAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_selectedAddress != null) {
        await prefs.setString('selected_address_id', _selectedAddress!.id);
      }
    } catch (e) {
      print('Error saving selected address: $e');
    }
  }

  // Order History Methods - UPDATE: Tambah parameter deliveryAddress
  void addOrder(List<CartItem> items, double total, String paymentMethod, String size, {Address? deliveryAddress}) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      total: total,
      paymentMethod: paymentMethod,
      date: DateTime.now(),
      size: size,
      deliveryAddress: deliveryAddress ?? _selectedAddress, // GUNAKAN alamat terpilih
    );
    
    _orders.insert(0, order); // Add to beginning for latest first
    _saveOrders();
    notifyListeners();
  }

  Future<void> _loadOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString('orders');
      if (ordersJson != null) {
        final List<dynamic> ordersList = json.decode(ordersJson);
        _orders = ordersList.map((orderJson) => Order.fromJson(orderJson)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading orders: $e');
    }
  }

  Future<void> _saveOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = json.encode(_orders.map((order) => order.toJson()).toList());
      await prefs.setString('orders', ordersJson);
    } catch (e) {
      print('Error saving orders: $e');
    }
  }

  // Payment Methods
  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    _savePaymentMethod();
    notifyListeners();
  }

  Future<void> _loadPaymentMethod() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _selectedPaymentMethod = prefs.getString('payment_method') ?? 'cash';
      notifyListeners();
    } catch (e) {
      print('Error loading payment method: $e');
    }
  }

  Future<void> _savePaymentMethod() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('payment_method', _selectedPaymentMethod);
    } catch (e) {
      print('Error saving payment method: $e');
    }
  }

  // Login/Logout methods
  bool login(String email, String password) {
    if (!email.endsWith('@gmail.com')) {
      return false;
    }
    
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    
    if (!hasLetter || !hasNumber || !hasSymbol) {
      return false;
    }
    
    _isLoggedIn = true;
    _userEmail = email;
    _userName = email.split('@').first;
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = '';
    _userName = '';
    notifyListeners();
  }

  // Cart methods
  void toggleFavorite(String coffeeId) {
    final index = _allCoffees.indexWhere((coffee) => coffee.id == coffeeId);
    if (index != -1) {
      _allCoffees[index].isFavorite = !_allCoffees[index].isFavorite;
      notifyListeners();
    }
  }

  void addToCart(Coffee coffee) {
    final existingIndex = _cartItems.indexWhere((item) => item.coffee.id == coffee.id);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(coffee: coffee, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String coffeeId) {
    _cartItems.removeWhere((item) => item.coffee.id == coffeeId);
    notifyListeners();
  }

  void updateCartQuantity(String coffeeId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.coffee.id == coffeeId);
    if (index != -1) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class CartItem {
  final Coffee coffee;
  int quantity;

  CartItem({
    required this.coffee,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'coffee': {
        'id': coffee.id,
        'name': coffee.name,
        'description': coffee.description,
        'price': coffee.price,
        'imageUrl': coffee.imageUrl,
        'category': coffee.category,
        'rating': coffee.rating,
        'isFavorite': coffee.isFavorite,
      },
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      coffee: Coffee(
        id: json['coffee']['id'],
        name: json['coffee']['name'],
        description: json['coffee']['description'],
        price: json['coffee']['price'],
        imageUrl: json['coffee']['imageUrl'],
        category: json['coffee']['category'],
        rating: json['coffee']['rating'],
        isFavorite: json['coffee']['isFavorite'],
      ),
      quantity: json['quantity'],
    );
  }
}

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final String paymentMethod;
  final DateTime date;
  final String size;
  final Address? deliveryAddress; // TAMBAHKAN: Alamat pengiriman

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.date,
    required this.size,
    this.deliveryAddress, // TAMBAHKAN: Alamat pengiriman
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
      'size': size,
      'deliveryAddress': deliveryAddress?.toJson(), // TAMBAHKAN: Simpan alamat
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List).map((itemJson) => CartItem.fromJson(itemJson)).toList(),
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      date: DateTime.parse(json['date']),
      size: json['size'],
      deliveryAddress: json['deliveryAddress'] != null 
          ? Address.fromJson(json['deliveryAddress']) 
          : null, // TAMBAHKAN: Load alamat
    );
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/coffee.dart';
import '../widgets/coffee_card.dart';
import '../widgets/category_button.dart';
import '../widgets/bottom_nav_bar.dart';
import 'detail_page.dart';
import 'favorite_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _updateSelectedIndex,
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return HomeContent(onNavigateToHome: () => _updateSelectedIndex(0));
      case 1:
        return FavoritePage();
      case 2:
        return CartPage(onNavigateToHome: () => _updateSelectedIndex(0));
      case 3:
        return ProfilePage();
      default:
        return HomeContent(onNavigateToHome: () => _updateSelectedIndex(0));
    }
  }
}

class HomeContent extends StatefulWidget {
  final VoidCallback onNavigateToHome;

  const HomeContent({Key? key, required this.onNavigateToHome}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> _categories = [
    'Semua',
    'Cappuccino',
    'Latte',
    'Espresso',
    'Americano',
    'Cold Brew'
  ];

  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _filterCoffees(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = '';
      _searchController.clear();
      _isSearching = false;
    });
  }

  void _navigateToDetail(BuildContext context, Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(coffee: coffee),
      ),
    );
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List<Coffee> _getFilteredCoffees(List<Coffee> allCoffees) {
    List<Coffee> filteredCoffees = _selectedCategory == 'Semua' 
        ? allCoffees 
        : allCoffees.where((coffee) => coffee.category == _selectedCategory).toList();

    if (_searchQuery.isNotEmpty) {
      filteredCoffees = filteredCoffees.where((coffee) {
        final nameLower = coffee.name.toLowerCase();
        final descriptionLower = coffee.description.toLowerCase();
        final queryLower = _searchQuery.toLowerCase();
        return nameLower.contains(queryLower) || descriptionLower.contains(queryLower);
      }).toList();
    }

    return filteredCoffees;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final List<Coffee> filteredCoffees = _getFilteredCoffees(appState.allCoffees);

    return SafeArea(
      child: Scaffold(
        appBar: _isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_isSearching) ...[
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: CategoryButton(
                          category: _categories[index],
                          isSelected: _selectedCategory == _categories[index],
                          onTap: () => _filterCoffees(_categories[index]),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _buildResultsTitle(),
              ),
              SizedBox(height: 8),
              
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    final childAspectRatio = constraints.maxWidth > 600 ? 0.75 : 0.68;
                    
                    return filteredCoffees.isEmpty && _searchQuery.isNotEmpty
                        ? _buildNoResults()
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: filteredCoffees.length,
                            itemBuilder: (context, index) {
                              final coffee = filteredCoffees[index];
                              return GestureDetector(
                                onTap: () => _navigateToDetail(context, coffee),
                                child: CoffeeCard(
                                  coffee: coffee,
                                  onFavoriteToggle: () {
                                    appState.toggleFavorite(coffee.id);
                                  },
                                  onAddToCart: () {
                                    appState.addToCart(coffee);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${coffee.name} ditambahkan ke keranjang!'),
                                        backgroundColor: Color(0xFFC67C4E),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildNormalAppBar() {
    return AppBar(
      title: Text(
        'Temukan kopi terbaik\nuntuk Anda',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.brown[800],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.brown, size: 22),
          onPressed: _startSearch,
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.brown),
        onPressed: _stopSearch,
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Cari kopi...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        style: TextStyle(fontSize: 16),
        onChanged: _updateSearchQuery,
      ),
      actions: [
        if (_searchQuery.isNotEmpty)
          IconButton(
            icon: Icon(Icons.clear, color: Colors.brown),
            onPressed: () {
              _searchController.clear();
              _updateSearchQuery('');
            },
          ),
      ],
    );
  }

  Widget _buildResultsTitle() {
    if (_searchQuery.isNotEmpty) {
      final resultCount = _getFilteredCoffees(Provider.of<AppState>(context).allCoffees).length;
      return Text(
        'Hasil Pencarian: "$_searchQuery" ($resultCount ditemukan)',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.brown[800],
        ),
      );
    } else {
      return Text(
        '${_selectedCategory} (${_getFilteredCoffees(Provider.of<AppState>(context).allCoffees).length})',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.brown[800],
        ),
      );
    }
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Kopi tidak ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba dengan kata kunci yang berbeda',
            style: TextStyle(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _stopSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC67C4E),
            ),
            child: Text('Hapus Pencarian'),
          ),
        ],
      ),
    );
  }
}
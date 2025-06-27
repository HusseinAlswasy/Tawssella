import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:payment/Screen/cart.dart';
import 'package:payment/Screen/details.dart' show ProductDetailsScreen;
import 'package:payment/Screen/fav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeStore extends StatelessWidget {
  const HomeStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontFamily: 'Cairo',
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Map<String, String>> cart = [];
  List<Map<String, String>> favorites = [];

  // دالة لتحميل البيانات من SharedPreferences
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart');
      final favoritesData = prefs.getString('favorites');

      setState(() {
        if (cartData != null) {
          cart = List<Map<String, String>>.from(jsonDecode(cartData)
              .map((item) => Map<String, String>.from(item)));
        }
        if (favoritesData != null) {
          favorites = List<Map<String, String>>.from(jsonDecode(favoritesData)
              .map((item) => Map<String, String>.from(item)));
        }
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  // دالة لحفظ البيانات في SharedPreferences
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cart', jsonEncode(cart));
      await prefs.setString('favorites', jsonEncode(favorites));
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  // دالة لإضافة منتج للسلة
  void addToCart(Map<String, String> product) {
    setState(() {
      cart.add(product);
    });
    _saveData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${product['name']} إلى السلة'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  // دالة لإزالة منتج من السلة
  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
    _saveData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إزالة المنتج من السلة'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red.shade600,
      ),
    );
  }

  // دالة لإضافة/إزالة منتج من المفضلة
  void addToFavorites(Map<String, String> product) {
    setState(() {
      if (!favorites.any((item) => item['name'] == product['name'])) {
        favorites.add(product);
      } else {
        favorites.removeWhere((item) => item['name'] == product['name']);
      }
    });
    _saveData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(favorites.any((item) => item['name'] == product['name'])
            ? 'تمت إضافة ${product['name']} إلى المفضلة'
            : 'تمت إزالة ${product['name']} من المفضلة'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue.shade600,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ProductsScreen(
        onAddToCart: addToCart,
        onAddToFavorites: addToFavorites,
        cart: cart,
        favorites: favorites,
      ),
      FavoritesScreen(
        favorites: favorites,
        onRemoveFromFavorites: addToFavorites,
      ),
      CartScreen(
        cart: cart,
        onRemove: removeFromCart,
      ),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'السلة',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  final Function(Map<String, String>) onAddToCart;
  final Function(Map<String, String>) onAddToFavorites;
  final List<Map<String, String>> cart;
  final List<Map<String, String>> favorites;

  ProductsScreen({
    super.key,
    required this.onAddToCart,
    required this.onAddToFavorites,
    required this.cart,
    required this.favorites,
  });

  final List<String> ads = [
    'https://images.pexels.com/photos/50987/money-card-business-credit-card-50987.jpeg?auto=format&fit=crop&w=600&h=200',
    'https://images.pexels.com/photos/6214474/pexels-photo-6214474.jpeg?auto=format&fit=crop&w=600&h=200',
    'https://images.pexels.com/photos/5239812/pexels-photo-5239812.jpeg?auto=format&fit=crop&w=600&h=200',
  ];

  final List<Map<String, String>> categories = [
    {'name': 'إلكترونيات', 'icon': '📱'},
    {'name': 'ملابس', 'icon': '👗'},
    {'name': 'أحذية', 'icon': '👟'},
    {'name': 'إكسسوارات', 'icon': '👜'},
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'سماعات AirPods Pro',
      'price': '999 ريال',
      'image':
          'https://m.media-amazon.com/images/I/61Amk1yTq7L.__AC_SX300_SY300_QL70_ML2_.jpg',
    },
    {
      'name': 'تيشيرت Adidas Originals',
      'price': '149 ريال',
      'image': 'https://m.media-amazon.com/images/I/61joDL9cZFL._AC_SX679_.jpg',
    },
    {
      'name': 'حذاء Nike Air Max',
      'price': '499 ريال',
      'image':
          'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?auto=format&fit=crop&w=150&h=150',
    },
    {
      'name': 'ساعة Apple Watch Series 9',
      'price': '1599 ريال',
      'image':
          'https://m.media-amazon.com/images/I/81W0yyu1VnL.__AC_SX300_SY300_QL70_ML2_.jpg',
    },
    {
      'name': 'جوال iPhone 14 Pro',
      'price': '4299 ريال',
      'image':
          'https://m.media-amazon.com/images/I/617uZpxrl1L.__AC_SX300_SY300_QL70_ML2_.jpg',
    },
    {
      'name': 'نظارة Ray-Ban Wayfarer',
      'price': '599 ريال',
      'image': 'https://m.media-amazon.com/images/I/51927085hAL._AC_SX679_.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر المنتجات'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          cart: cart,
                          onRemove: (index) {
                            Navigator.of(context).pop();
                            (context.findAncestorStateOfType<
                                    _MainScreenState>())!
                                .removeFromCart(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ads.isEmpty
                ? const SizedBox(
                    height: 200,
                    child: Center(child: Text('لا توجد إعلانات')),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: .95,
                    ),
                    items: ads.map((ad) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: ad,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'الفئات',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          categories[index]['icon']!,
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categories[index]['name']!,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'المنتجات',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final isFavorite =
                    favorites.any((item) => item['name'] == product['name']);
                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                          onAddToFavorites: onAddToFavorites,
                          isFavorite: isFavorite,
                        ),
                      ),
                    );
                    if (result != null && result is Map<String, String>) {
                      onAddToCart(result);
                    }
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: product['image']!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () => onAddToFavorites(product),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            product['price']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => onAddToCart(product),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 36),
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('إضافة للسلة'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

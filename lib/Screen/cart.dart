import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:payment/Screen/payment/my_cart_view.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cart;
  final void Function(int index) onRemove;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: cart.isEmpty
          ? const Center(child: Text('السلة فارغة'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                if (product['name'] == null ||
                    product['price'] == null ||
                    product['image'] == null) {
                  return const ListTile(
                    title: Text('خطأ في البيانات'),
                  );
                }
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image),
                    ),
                    title: Text(product['name']!),
                    subtitle: Text(product['price']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyCartView()),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_basket_rounded,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            onRemove(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تمت إزالة المنتج من السلة'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

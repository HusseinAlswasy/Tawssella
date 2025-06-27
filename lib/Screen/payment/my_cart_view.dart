import 'package:flutter/material.dart';
import 'package:payment/core/styels.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_view_body.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Cart',
          textAlign: TextAlign.center,
          style: Styels.style25,
        ),
      ),
      body: CartViewBody(),
    );
  }
}

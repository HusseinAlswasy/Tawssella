import 'package:flutter/material.dart';
import 'package:payment/core/styels.dart';
import 'package:payment/Screen/payment/payement_details_view.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_button.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_order_info.dart'
    show OrderInfoItem;

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(child: Image.asset('assets/images/Group 6.png')),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(
            title: 'Order SubTotal',
            value: '42.9\$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'DisCount',
            value: '0\$',
          ),
          const Divider(
            thickness: 2.0,
            color: Colors.grey,
            indent: 16.0,
            endIndent: 16.0,
            height: 20.0,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Text(
                'Total',
                textAlign: TextAlign.center,
                style: Styels.style24,
              ),
              Spacer(),
              Text(
                '42.9\$',
                textAlign: TextAlign.center,
                style: Styels.style24,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          CartButton(
            text: "Complete Payment",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayementDetailsView(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

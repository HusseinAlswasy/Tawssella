import 'package:flutter/material.dart';

import 'Cont_card_payment.dart';

class PaymentMethodListView extends StatefulWidget {
  PaymentMethodListView({super.key, required this.updatePayementMethod});

  final Function({required int index}) updatePayementMethod;
  @override
  State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
}

class _PaymentMethodListViewState extends State<PaymentMethodListView> {
  @override
  List<String> paymentMethodItem = [
    'assets/images/payment.svg',
    'assets/images/paypal.svg',
  ];
  int ActiveIndex = 0;

  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: paymentMethodItem.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: GestureDetector(
              onTap: () {
                ActiveIndex = index;
                setState(() {});
                widget.updatePayementMethod(index: ActiveIndex);
              },
              child: ContCardPayment(
                image: paymentMethodItem[index],
                isActive: ActiveIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}

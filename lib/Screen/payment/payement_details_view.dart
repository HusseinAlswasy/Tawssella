
import 'package:flutter/material.dart';
import 'package:payment/core/styels.dart';
import 'package:payment/feature/checkout/presentation/views/widget/payment_details_body.dart';

class PayementDetailsView extends StatelessWidget {
  const PayementDetailsView({super.key});

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
    body: PaymentDetailsBody(),
    );
  }
}
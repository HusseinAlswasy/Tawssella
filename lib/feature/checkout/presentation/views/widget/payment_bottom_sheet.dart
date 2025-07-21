import 'package:flutter/material.dart';
import 'package:payment/feature/checkout/presentation/views/widget/custome_button_bloc_Consumer.dart';
import 'package:payment/feature/checkout/presentation/views/widget/payment_Method_List_View.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaymentMethodListView(),
          const SizedBox(
            height: 32,
          ),
          CustomButtonBlocConsumer(),
        ],
      ),
    );
  }
}

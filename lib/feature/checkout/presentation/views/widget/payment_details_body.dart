import 'package:flutter/material.dart';
import 'package:payment/Screen/payment/thankYou.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_button.dart';
import 'package:payment/feature/checkout/presentation/views/widget/payment_Method_List_View.dart';
import 'custom_credit_card.dart';

class PaymentDetailsBody extends StatefulWidget {
  const PaymentDetailsBody({super.key});

  @override
  State<PaymentDetailsBody> createState() => _PaymentDetailsBodyState();
}

class _PaymentDetailsBodyState extends State<PaymentDetailsBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PaymentMethodListView(),
        ),
        SliverToBoxAdapter(
          child: CustomCreditCard(
            formKey: formKey,
            autovalidateMode: autovalidateMode,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                left: 16,
                right: 16,
              ),
              child: CartButton(
                text: "Payment",
                onTap: () {
                  // if (formKey.currentState!.validate()) {
                  //   formKey.currentState!.save();
                  // } else {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const Thankyou()));
                  //   autovalidateMode = AutovalidateMode.always;
                  //   setState(() {
                  //   });
                  // }
  showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) {
                    return const PaymentBottomSheet();
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16,),
          PaymentMethodListView(),
          const SizedBox(height: 32,),
          CartButton(text: 'Continue'),
        ],
      ),
    );
  }
}
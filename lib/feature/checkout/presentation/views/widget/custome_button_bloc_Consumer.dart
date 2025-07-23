import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/feature/checkout/presentation/manger/cubits/payment/cubit/payment_cubit_cubit.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_button.dart';
import 'package:payment/feature/checkout/presentation/views/widget/thank_you_view_body.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubitCubit, PaymentCubitState>(
      listener: (context, state) {
        if (state is PaymentCubitSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const ThankyouViewBody();
              },
            ),
          );
        }
        if (state is PaymentCubitFailuer) {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(content: Text(state.errorMesssage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CartButton(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId: "YOUR CLIENT ID",
                secretKey: "YOUR SECRET KEY",
                transactions: const [
                  {
                    "amount": {
                      "total": "100",
                      "currency": "USD",
                      "details": {
                        "subtotal": "100",
                        "shipping": "0",
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": "10",
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": "12",
                          "currency": "USD"
                        }
                      ],
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  log("onSuccess: $params");
                  Navigator.pop(context);
                },
                onError: (error) {
                  log("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                  Navigator.pop(context);
                },
              ),
            ));
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //   amount: '100',
            //   currency: 'USD',
            //   customerId: 'cus_Si8zo4eXLDSxH7',
            // );
            // BlocProvider.of<PaymentCubitCubit>(context)
            //     .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isLoading: state is PaymentCubLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}




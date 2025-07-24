import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/Screen/payment/my_cart_view.dart';
import 'package:payment/Screen/payment/thankYou.dart';
import 'package:payment/core/utlis/api_keys.dart';
import 'package:payment/feature/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/feature/checkout/data/models/amount_model/details.dart';
import 'package:payment/feature/checkout/data/models/item_list_model/item.dart';
import 'package:payment/feature/checkout/data/models/item_list_model/item_list_model.dart';
import 'package:payment/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/feature/checkout/presentation/manger/cubits/payment/cubit/payment_cubit_cubit.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_button.dart';
import 'package:payment/feature/checkout/presentation/views/widget/cart_order_info.dart';
import 'package:payment/feature/checkout/presentation/views/widget/thank_you_view_body.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.isPaypal,
  });

  final bool isPaypal;
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
            if (isPaypal) {
              var transaction = getTransctions();
              paypalPayment(context, transaction);
            } else {
              StripePayment(context);
            }
          },
          isLoading: state is PaymentCubLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }

  void StripePayment(BuildContext context) {
    PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
      amount: '100',
      currency: 'USD',
      customerId: 'cus_Si8zo4eXLDSxH7',
    );
    BlocProvider.of<PaymentCubitCubit>(context)
        .makePayment(paymentIntentInputModel: paymentIntentInputModel);
  }

  void paypalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel item_list}) transaction) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientID,
        secretKey: ApiKeys.SecretKeyPaypal,
        transactions: [
          {
            "amount": transaction.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transaction.item_list.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return Thankyou();
          }), (route) {
            if (route.settings.name == '/') {
              return true;
            } else {
              return false;
            }
          });
        },
        onError: (error) {
          SnackBar snackBar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
                return MyCartView();
              }), (route) {
                if (route.settings.name == '/') {
                  return true;
                } else {
                  return false;
                }
              });
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({AmountModel amount, ItemListModel item_list}) getTransctions() {
    var amount = AmountModel(
      total: "100",
      currency: 'USD',
      details: Details(
        shipping: "0",
        shippingDiscount: 0,
        subtotal: "100",
      ),
    );

    List<Item> orders = [
      Item(
        currency: 'USD',
        name: 'Apple',
        price: "4",
        quantity: 10,
      ),
      Item(
        currency: 'USD',
        name: 'Apple',
        price: "5",
        quantity: 12,
      ),
    ];

    var item_list = ItemListModel(orders: orders);

    return (amount: amount, item_list: item_list);
  }
}

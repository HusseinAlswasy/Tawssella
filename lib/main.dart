import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Screen/home.dart';
import 'package:payment/core/utlis/api_keys.dart';

void main() {
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(
    const HomeStore(),
  );
}


// for save cards for users

//1 - payment intent(amount,currency,customerId)
//2 - first create account and create customer object id
//3 - ephemeral key( cutomerid)
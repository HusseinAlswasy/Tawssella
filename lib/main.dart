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
 

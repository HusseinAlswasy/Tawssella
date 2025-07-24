import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/errors/failuers.dart';
import 'package:payment/core/utlis/stripe_services.dart';
import 'package:payment/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/feature/checkout/data/repos/checkout_repo.dart';

class CeckoutRepoImpl extends CheckoutRepo {
  final StripeServices stripeServices = StripeServices();
  @override
  Future<Either<Failuer, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeServices.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } on StripeException catch(e){
      return left(ServerFailuer(errorMesssage: e.error.message?? 'OOPs There Was than Error'));
    }
    catch (e) {
      return left(ServerFailuer(errorMesssage: e.toString()));
    }
  }
}

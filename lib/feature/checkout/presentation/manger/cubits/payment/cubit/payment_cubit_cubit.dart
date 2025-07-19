
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment/feature/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/feature/checkout/data/repos/checkout_repo.dart';
part 'payment_cubit_state.dart';

class PaymentCubitCubit extends Cubit<PaymentCubitState> {
  PaymentCubitCubit(this.checkoutRepo) : super(PaymentCubitInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentCubLoading());

    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    data.fold(
      (L) => emit(PaymentCubitFailuer(errorMesssage: L.errorMesssage)),
      (r) => emit(
        PaymentCubitSuccess(),
      ),
    );
  }
  @override
  void onChange(Change<PaymentCubitState> change) {
    log(change.toString());
    super.onChange(change);
  }
}



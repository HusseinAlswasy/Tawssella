import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          onTap: (){
            PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(amount: '100', currency: 'USD',customerId: 'cus_Si8zo4eXLDSxH7');
            BlocProvider.of<PaymentCubitCubit>(context).makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isLoading: state is PaymentCubLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}

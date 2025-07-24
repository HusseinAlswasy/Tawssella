import 'package:flutter/material.dart';
import 'package:payment/feature/checkout/presentation/views/widget/custome_button_bloc_Consumer.dart';
import 'package:payment/feature/checkout/presentation/views/widget/payment_Method_List_View.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  bool isPaypal = false;
updatePayementMethod({required int index}){
  if(index==0){
  isPaypal = false;
  }else{
    isPaypal = true;
  }
  setState(() {
    
  });
}
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
          PaymentMethodListView(updatePayementMethod: updatePayementMethod,),
          const SizedBox(
            height: 32,
          ),
          CustomButtonBlocConsumer(isPaypal: isPaypal,),
        ],
      ),
    );
  }
}

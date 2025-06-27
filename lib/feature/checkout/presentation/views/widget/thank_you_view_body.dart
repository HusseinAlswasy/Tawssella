import 'package:flutter/material.dart';
import 'package:payment/feature/checkout/presentation/views/widget/Custome_Checken_Button.dart';
import 'package:payment/feature/checkout/presentation/views/widget/ThankDashedLine.dart';
import 'package:payment/feature/checkout/presentation/views/widget/thank_you_card.dart';

class ThankyouViewBody extends StatelessWidget {
  const ThankyouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouCard(),
          ThankDashedLine(),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2,
            left: -20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2,
            right: -20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -40,
            child: CustomeCheckIcon(),
          ),
        ],
      ),
    );
  }
}

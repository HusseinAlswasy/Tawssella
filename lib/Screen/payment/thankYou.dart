import 'package:flutter/material.dart';
import 'package:payment/feature/checkout/presentation/views/widget/custom_appBar.dart';
import '../../feature/checkout/presentation/views/widget/thank_you_view_body.dart';

class Thankyou extends StatelessWidget {
  const Thankyou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: Transform.translate(
        offset: Offset(0, -10),
        child: ThankyouViewBody(),
      ),
    );
  }
}

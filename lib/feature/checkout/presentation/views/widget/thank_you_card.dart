import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment/core/styels.dart';
import 'package:payment/feature/checkout/presentation/views/widget/info_thank_you_credit.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 672,
      decoration: ShapeDecoration(
        color: Color(0xFFF1F0F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 22, right: 22),
        child: Column(
          children: [
            Text(
              "Thank You!",
              style: Styels.style25,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "Your Transaction was successful",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            const PaymentItemInfo(
              title: 'Date',
              value: '01/12/2025',
            ),
            const SizedBox(
              height: 15,
            ),
            const PaymentItemInfo(
              title: 'Time',
              value: '10:15 PM',
            ),
            const SizedBox(
              height: 20,
            ),
            const PaymentItemInfo(
              title: 'To',
              value: 'Hussein Hassan',
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Styels.style18,
                  textAlign: TextAlign.center,
                ),
                Text(
                  r'$56.78',
                  style: Styels.style18,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const InfoMasterCardthank(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/SVGRepo_iconCarrier.svg',
                    height: 50,
                  ),
                  Container(
                    width: 113,
                    height: 58,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1.5,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "PAID",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentItemInfo extends StatelessWidget {
  const PaymentItemInfo({super.key, required this.title, required this.value});

  @override
  final String title, value;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Styels.style18,
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: Styels.style18,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

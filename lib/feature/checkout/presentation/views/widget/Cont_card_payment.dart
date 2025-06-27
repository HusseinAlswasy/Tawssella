import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContCardPayment extends StatelessWidget {
  ContCardPayment({super.key, required this.image, this.isActive = false});

  @override
  String image;
  final bool isActive;
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: 60,
      width: 100,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: isActive ? Colors.green : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: SvgPicture.asset(image),
        ),
      ),
    );
  }
}

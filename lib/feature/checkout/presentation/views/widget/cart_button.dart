import 'package:flutter/material.dart';
import 'package:payment/core/styels.dart';

class CartButton extends StatelessWidget {
  CartButton(
      {super.key, this.onTap, required this.text, this.isLoading = false});
  void Function()? onTap;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green,
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Styels.style18,
                ),
              ),
      ),
    );
  }
}

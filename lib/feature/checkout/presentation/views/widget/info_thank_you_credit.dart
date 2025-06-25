import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoMasterCardthank extends StatelessWidget {
  const InfoMasterCardthank({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      height: 73,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 22,right: 22,top: 16,bottom: 16),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/logo.svg'),
            SizedBox(width: 23,),
            Column(
              children: [
                Text("Credit Card"),
                Text("Mastercard"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

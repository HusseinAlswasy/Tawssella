
import 'package:flutter/material.dart';

class CustomeCheckIcon extends StatelessWidget {
  const CustomeCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Color(0xFFD9D9D9),
      child: CircleAvatar(
        radius: 35,
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}


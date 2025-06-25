import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styels.dart' show Styels;

AppBar CustomAppBar ({final String? title}) {
    return AppBar(
      leading: Center(
        child: SvgPicture.asset('assets/images/Arrow 1.svg'),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(title??'',textAlign: TextAlign.center,style: Styels.style25,),
    );
}
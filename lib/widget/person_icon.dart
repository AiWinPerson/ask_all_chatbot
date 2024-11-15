import 'package:flutter/material.dart';

import '../util/color_set.dart';

class PersonIcon extends StatelessWidget {
  const PersonIcon({
    super.key,
    required this.diameter,
    this.iconSize = 32,
    this.bgColor = ColorSet.whiteOpacity600,
    this.personColor = ColorSet.whiteOpacity800
  });

  final double diameter;
  final double iconSize;
  final Color bgColor;
  final Color personColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle,color: bgColor),
      child: Icon(Icons.person,color: personColor,size: iconSize,),
    );
  }
}

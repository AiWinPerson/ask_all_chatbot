import 'package:flutter/material.dart';

import '../util/color_set.dart';
import 'person_icon.dart';

class AvatarTitle extends StatelessWidget {
  const AvatarTitle({
    super.key,
    required this.title,
    this.bgColor = ColorSet.whiteOpacity600,
    required this.onTap
  });

  final String title;
  final Color bgColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Row(
            children: [
              PersonIcon(
                diameter: 45,
                bgColor: bgColor,
              ),
              const SizedBox(width: 20,),
              Text(title,style: const TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}

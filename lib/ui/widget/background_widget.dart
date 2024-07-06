
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Background extends StatelessWidget {
  const Background({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.color,
    required this.child,
  });

  final double height;
  final double width;
  final double borderRadius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class CardW extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final double? height;
  final Color? shadowColor;
  final double? width;
  final double? elevation;
  final Color? color;
  final Color? surfaceTintColor;
  const CardW({
    super.key,
    this.color,
    this.surfaceTintColor = Colors.transparent,
    this.elevation = 0.0,
    this.shadowColor,
    this.height,
    this.width,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      color: color,
      elevation: elevation,
      surfaceTintColor: surfaceTintColor,
      child: SizedBox(
        height: height,
        width: width,
        child: ListTile(
          enabled: false,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }
}

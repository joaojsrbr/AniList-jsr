import 'package:flutter/material.dart';

class BuildWidget extends StatelessWidget {
  final bool avatar;
  final bool colorfilter;
  const BuildWidget(
      {super.key,
      required this.builder,
      required this.avatar,
      required this.colorfilter});
  final Widget Function(bool avatar, bool colorfilter) builder;

  @override
  Widget build(BuildContext context) {
    return builder(avatar, colorfilter);
  }
}

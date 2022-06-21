// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class ColoredTabBar extends ColoredBox implements PreferredSizeWidget {
  const ColoredTabBar({required this.color, required this.tabBar, super.key})
      : super(color: color, child: tabBar);

  @override
  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;
}

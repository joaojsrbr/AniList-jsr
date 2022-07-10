import 'package:flutter/material.dart';

class AppColors {
  Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  Color background(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  Color secondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  Color tertiary(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }
}

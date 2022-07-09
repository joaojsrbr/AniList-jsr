import 'package:flutter/material.dart';

class AppColors {
  Color primarys(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  Color backgrounds(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  Color secondarys(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  Color tertiarys(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }
}

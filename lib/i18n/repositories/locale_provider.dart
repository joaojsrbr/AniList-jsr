import 'dart:collection';

import 'package:localization/localization.dart';

class LocaleProvider {
  List<String> _tabs = [];

  LocaleProvider() {
    _oninit();
  }

  UnmodifiableListView<String> get tabs => UnmodifiableListView(_tabs);

  // Tabslocale get tabs => _tabs;

  Future<void> _oninit() async {
    _tabs = [
      'overview'.i18n(),
      'characters'.i18n(),
      'staff'.i18n(),
      'social'.i18n(),
      'stats'.i18n(),
    ];
  }
}

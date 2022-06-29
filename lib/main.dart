import 'package:ani_search/locales/support_locales.dart';
import 'package:ani_search/my_app.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    KLocalizations.asChangeNotifier(
      locale: SLocales.supportedLocales[0],
      defaultLocale: SLocales.supportedLocales[0],
      supportedLocales: SLocales.supportedLocales,
      localizationsAssetsPath: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

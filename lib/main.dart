import 'package:anisearch2/locales/support_locales.dart';
import 'package:anisearch2/my_app.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:flutter/material.dart';

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

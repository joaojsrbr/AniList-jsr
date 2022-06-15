import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import 'package:anisearch2/api/repositories/manga_anime_provider.dart';
import 'package:anisearch2/locales/support_locales.dart';
import 'package:anisearch2/module/page/homepage_module.dart';
import 'package:anisearch2/module/page/mangadetailsr_module.dart';
import 'package:anisearch2/module/page/mangagridm_module.dart';
import 'package:anisearch2/module/page/mangagrids_module.dart';
import 'package:anisearch2/screens/homePage/binding/binding.dart';
import 'package:anisearch2/screens/mangaDetails/manga_details.dart';
import 'package:anisearch2/theme/text_theme.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;

    final localizations = KLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            // On Android S+ devices, use the provided dynamic color scheme.
            // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
            lightColorScheme = lightDynamic.harmonized();
            // (Optional) Customize the scheme as desired. For example, one might
            // want to use a brand color to override the dynamic [ColorScheme.secondary].

            // Repeat for the dark color scheme.
            darkColorScheme = darkDynamic.harmonized();
          } else {
            // Otherwise, use fallback schemes.
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 129, 6),
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 197, 6),
              brightness: Brightness.dark,
            );
          }
          return GetMaterialApp(
            locale: localizations.locale,
            supportedLocales: localizations.supportedLocales,
            localizationsDelegates: [
              localizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: texttheme1(),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                elevation: 0,
              ),
              colorScheme: lightColorScheme,
              // extensions: [lightCustomColors],
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: const Color.fromARGB(239, 4, 207, 112),
              //   brightness: lightDynamic!.brightness,
              //   secondary: const Color.fromARGB(255, 232, 1, 244),
              //   background: lightDynamic.background,
              // ),
            ),
            title: 'AsS',
            // initialBinding: ControllerBinding(),
            darkTheme: ThemeData(
              useMaterial3: true,
              textTheme: texttheme1(),
              appBarTheme: const AppBarTheme(
                elevation: 0,
              ),
              colorScheme: darkColorScheme,
              // extensions: [darkCustomColors],
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: const Color.fromARGB(210, 65, 170, 5),
              //   brightness: darkDynamic!.brightness,
              //   secondary: const Color.fromARGB(255, 232, 1, 244),
              //   background: darkDynamic.background,
              // ),
            ),
            initialRoute: '/h',
            getPages: [
              // GetPage(name: '/r', page: () => const HomepageRouter()),
              GetPage(
                binding: ControllerBinding(),
                name: '/h',
                page: () => const HomepageModule(),
              ),
              GetPage(
                name: '/g',
                page: () => const MangaGridMModule(),
              ),
              GetPage(
                name: '/s',
                page: () => const MangaGridSModule(),
              ),
              GetPage(
                binding: MangaDetailsRBinding(),
                name: '/d',
                page: () => const MangaDetailsRModule(),
              ),
            ],
          );
        },
      ),
    );
  }
}

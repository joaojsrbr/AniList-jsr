import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import 'package:anisearch2/api/repositories/anime_provider.dart';
import 'package:anisearch2/api/repositories/manga_provider.dart';
import 'package:anisearch2/api/repositories/search_provider.dart';
import 'package:anisearch2/module/page/homepage_module.dart';
import 'package:anisearch2/module/page/mangadetailsr_module.dart';
import 'package:anisearch2/module/page/mangagridm_module.dart';
import 'package:anisearch2/module/page/mangagrids_module.dart';
import 'package:anisearch2/screens/home/binding/binding.dart';
import 'package:anisearch2/scroll/scrollbehavior.dart';
import 'package:anisearch2/theme/text_theme.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MangaProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (context) => AnimeProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (context) => SearchProvider(),
        ),
      ],
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            lightColorScheme = lightDynamic.harmonized();

            darkColorScheme = darkDynamic.harmonized();
          } else {
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 129, 6),
              background: const Color.fromRGBO(35, 36, 54, 1),
              surfaceTint: const Color.fromRGBO(35, 36, 54, 1),
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 197, 6),
              background: const Color.fromRGBO(35, 36, 54, 1),
              surfaceTint: const Color.fromRGBO(35, 36, 54, 1),
              brightness: Brightness.dark,
            );
          }
          return GetMaterialApp(
            color: Theme.of(context).colorScheme.background,
            locale: localizations.locale,
            supportedLocales: localizations.supportedLocales,
            localizationsDelegates: [
              localizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            scrollBehavior: MyScrollBehavior(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: texttheme1(),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                elevation: 0,
              ),
              colorScheme: lightColorScheme,
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
            ),

            initialRoute: '/h',
            initialBinding: ControllerBinding(),
            getPages: [
              // GetPage(name: '/r', page: () => const HomepageRouter()),
              GetPage(
                name: '/h',
                page: () => const HomepageModule(),
              ),
              GetPage(
                name: '/g',
                page: () => const GridMModule(),
              ),
              GetPage(
                name: '/s',
                page: () => const GridSModule(),
              ),
              GetPage(
                name: '/d',
                page: () => const DetailsRModule(),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import 'package:ani_search/api/repositories/anime_provider.dart';
import 'package:ani_search/api/repositories/manga_provider.dart';
import 'package:ani_search/api/repositories/search_provider.dart';
import 'package:ani_search/i18n/repositories/locale_provider.dart';
import 'package:ani_search/module/page/detailsr_module.dart';
import 'package:ani_search/module/page/homepage_module.dart';
import 'package:ani_search/screens/home/binding/binding.dart';
import 'package:ani_search/scroll/scrollbehavior.dart';
import 'package:ani_search/theme/text_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugInvertOversizedImages = true;
    }
    LocalJsonLocalization.delegate.directories = ['i18n'];

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => HiveService(),
        // ),
        Provider(
          create: (context) => LocaleProvider(),
        ),
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
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('pt', 'BR'),
            ],
            localizationsDelegates: [
              // delegate from flutter_localization
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // delegate from localization package.
              LocalJsonLocalization.delegate,
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
            title: 'AniList-jsr',
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
            getPages: _pages,
          );
        },
      ),
    );
  }
}

List<GetPage<dynamic>> _pages = [
  // GetPage(name: '/r', page: () => const HomepageRouter()),
  GetPage(
    name: '/h',
    page: () => const HomepageModule(),
  ),
  GetPage(
    name: '/d',
    page: () => const DetailsRModule(),
  ),
];

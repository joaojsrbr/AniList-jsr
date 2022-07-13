import 'package:ani_search/app/modules/details/bindings/details_binding.dart';
import 'package:ani_search/app/modules/details/view/details_view.dart';
import 'package:ani_search/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const Homepage(),
      // binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.details,
      page: () => const MangaDetailsR(),
      binding: DetailsBinding(),
    ),
  ];
  static const initial = Routes.home;
}

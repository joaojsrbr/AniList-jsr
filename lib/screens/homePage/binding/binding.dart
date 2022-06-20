import 'package:anisearch2/screens/homePage/controller/controller.dart';
import 'package:get/get.dart';

import '../../mangaGrid/controller/controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(HomepageController());
    Get.put<MangaGridSController>(MangaGridSController());
    // Get.put<TrendsController>(TrendsController());
  }
}

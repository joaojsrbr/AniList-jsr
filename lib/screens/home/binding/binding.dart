import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:get/get.dart';

import '../../grid/controller/controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(HomepageController());
    Get.put<MangaGridSController>(MangaGridSController());
    // Get.put<TrendsController>(TrendsController());
  }
}

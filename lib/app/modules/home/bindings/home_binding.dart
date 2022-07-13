import 'package:ani_search/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomepageController());
    // Get.put<TrendsController>(TrendsController());
  }
}

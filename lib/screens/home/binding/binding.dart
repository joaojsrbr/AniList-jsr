import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(HomepageController());
    // Get.put<TrendsController>(TrendsController());
  }
}

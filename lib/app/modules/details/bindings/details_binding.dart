import 'package:ani_search/app/modules/details/controllers/details_controller.dart';
import 'package:get/get.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController());
  }
}

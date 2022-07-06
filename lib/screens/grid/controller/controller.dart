// ignore_for_file: file_names

import 'package:ani_search/screens/home/controller/controller.dart';
import 'package:get/get.dart';

// import '../../home/controller/controller.dart';

class MangaGridSController extends GetxController {
  RxInt page = 1.obs;
  RxInt index = 0.obs;

  // * GridView.builder
  RxBool select0 = true.obs;

  Future<void> loadmore(context, sort, type) async {
    Get.find<HomepageController>().streamController.add(
          Root(
            context: context,
            sort: sort,
            type: type,
            // type: lista!.first.type,
            // popula: popula,
          ),
        );
  }

  // * GridView.builder 2
  RxBool select1 = false.obs;

  // * ListView
  RxBool select2 = false.obs;

  void selectOne(int index) {
    if (index == 0) {
      select0.value = true;
      select1.value = false;
      select2.value = false;
      update([28]);
    } else if (index == 1) {
      select1.value = true;
      select0.value = false;
      select2.value = false;
      update([28]);
    } else {
      select2.value = true;
      select1.value = false;
      select0.value = false;
      update([28]);
    }
  }
}

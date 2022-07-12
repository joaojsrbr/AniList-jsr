// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectButtonController extends GetxController {
  SelectButtonController({
    required this.children,
    required this.initvalue,
  });
  List<Widget> children;
  final int initvalue;

  late RxList<bool> isSelected;

  onPressed(int index) {
    isSelected.value = isSelected.map((element) => element = false).toList();

    isSelected[index] = !isSelected[index];
  }

  void init(int index) {
    isSelected[index] = !isSelected[index];
  }

  // * Ao Iniciar
  @override
  void onInit() {
    isSelected = RxList();
    for (var i in children) {
      isSelected.add(false);
    }
    init(initvalue);
    super.onInit();
  }

  Key stringkey(Key? key, String name) {
    return Key('#$name-$key');
  }

  // @override
  // void dispose() {
  //   isSelected = RxList();
  //   super.dispose();
  // }
}

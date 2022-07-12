// ignore_for_file: unused_local_variable

import 'package:ani_search/screens/home/widget/select_button/models/select_button_config_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectButtonController extends GetxController {
  SelectButtonController({
    required this.children,
    required this.initvalue,
  });
  final List<Widget> children;
  final int initvalue;

  RxList<bool> isSelected = RxList();

  onPressed(int index) {
    isSelected.value = isSelected.map((element) => element = false).toList();

    isSelected[index] = !isSelected[index];
    update([#SelectButton]);
  }

  void init(int index) {
    isSelected[index] = !isSelected[index];
  }

  // * Ao Iniciar
  @override
  void onInit() {
    for (var i in children) {
      isSelected.add(false);
    }
    init(initvalue);
    super.onInit();
  }

  void didChangeDependencies(GetBuilderState<SelectButtonController> state,
      SelectButtonConfig config) {
    if (state.controller?.children.length != children.length) {
      state.controller?.isSelected = RxList();
      for (var i in children) {
        state.controller?.isSelected.add(false);
      }
      state.controller?.init(config.initvalue);
    } else if (state.controller?.isSelected.length != children.length) {
      state.controller?.isSelected = RxList();
      for (var i in children) {
        state.controller?.isSelected.add(false);
      }
      state.controller?.init(config.initvalue);
    }
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

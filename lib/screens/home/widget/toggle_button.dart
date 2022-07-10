// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButtonController extends GetxController {
  ToggleButtonController({
    required this.children,
    required this.initvalue,
  });
  List<Widget> children;
  int initvalue;

  RxList<bool> isSelected = RxList();

  onPressed(int index) {
    isSelected.value = isSelected.map((element) => element = false).toList();

    isSelected[index] = !isSelected[index];

    update([(#ToggleButtonController).toString()]);
  }

  void init() {
    isSelected[initvalue] = !isSelected[initvalue];
    update([(#ToggleButtonController).toString()]);
  }

  @override
  void onInit() {
    for (var i in children) {
      isSelected.add(false);
    }
    init();
    super.onInit();
  }
}

const int _initialvalue = 0;

class ToggleButton extends GetView<ToggleButtonController> {
  const ToggleButton({
    required this.children,
    this.onPressed,
    this.onPresseds,
    this.isSelected,
    this.initvalue = _initialvalue,
    this.selectedColor,
    this.disabledColor,
    this.fillColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.color,
    this.focusNodes,
    this.renderBorder = true,
    this.borderColor,
    this.selectedBorderColor,
    this.disabledBorderColor,
    this.borderRadius,
    this.borderWidth,
    this.direction = Axis.horizontal,
    this.verticalDirection = VerticalDirection.down,
    this.tapTargetSize,
    this.textStyle,
    this.constraints,
    this.mouseCursor,
    this.normal = false,
    super.key,
  }) : onmain = (onPressed != null) ? onPressed : onPresseds;

  final int initvalue;

  final void Function(int)? onmain;

  final bool normal;

  final List<bool>? isSelected;

  final void Function(int)? onPresseds;

  final void Function(int)? onPressed;

  final List<Widget> children;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? fillColor;
  final Color? focusColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? color;
  final List<FocusNode>? focusNodes;
  final bool renderBorder;

  final Color? borderColor;
  final Color? selectedBorderColor;
  final Color? disabledBorderColor;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Axis direction;
  final VerticalDirection verticalDirection;
  final MaterialTapTargetSize? tapTargetSize;
  final TextStyle? textStyle;
  final BoxConstraints? constraints;

  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => ToggleButtonController(
        children: children,
        initvalue: initvalue,
      ),
    );

    return GetBuilder<ToggleButtonController>(
      didChangeDependencies: (_) {
        if (_.controller?.children.length != children.length) {
          _.controller?.isSelected.value = RxList();
          for (var i in children) {
            _.controller?.isSelected.add(false);
          }
        }
      },
      assignId: true,
      id: (#ToggleButtonController).toString(),
      builder: (controller) => ToggleButtons(
        key: key,
        color: color,
        textStyle: textStyle,
        constraints: constraints,
        tapTargetSize: tapTargetSize,
        selectedBorderColor: selectedBorderColor,
        disabledBorderColor: disabledBorderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        direction: direction,
        verticalDirection: verticalDirection,
        borderColor: borderColor,
        selectedColor: selectedColor,
        disabledColor: disabledColor,
        fillColor: fillColor,
        focusNodes: focusNodes,
        focusColor: focusColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        renderBorder: renderBorder,
        splashColor: splashColor,
        isSelected: normal ? isSelected! : controller.isSelected,
        onPressed: (index) {
          controller.onPressed(index);
          if (onPressed != null) {
            normal ? onmain!(index) : onmain!(index);
          }
        },
        mouseCursor: mouseCursor,
        children: children,
      ),
    );
  }
}

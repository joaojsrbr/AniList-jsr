// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const int _initialvalue = 0;

class Animation {
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  Color? color;
  Decoration? decoration;
  Decoration? foregroundDecoration;
  double? width;
  double? height;
  BoxConstraints? constraints;
  EdgeInsetsGeometry? margin;
  Matrix4? transform;
  AlignmentGeometry? transformAlignment;
  Widget? child;
  Clip clipBehavior;
  Curve curve;
  Duration duration;
  void Function()? onEnd;
  Animation({
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
  });
}

class ToggleButtonConfig {
  Animation? animation;
  final bool normal;

  final int initvalue;

  ToggleButtonConfig({
    this.animation,
    this.initvalue = _initialvalue,
    this.normal = false,
  });
}

class ToggleButtonController extends GetxController {
  ToggleButtonController({
    required this.children,
    required this.initvalue,
  });
  List<Widget> children;
  final int initvalue;

  RxList<bool> isSelected = RxList();

  onPressed(int index) {
    isSelected.value = isSelected.map((element) => element = false).toList();

    isSelected[index] = !isSelected[index];

    // update([(#GetBuilder).toString()]);
  }

  void init(index) {
    isSelected[index] = !isSelected[index];
    // update([(#GetBuilder).toString()]);
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

  // @override
  // void dispose() {
  //   isSelected = RxList();
  //   super.dispose();
  // }
}

class SelectButton extends GetView<ToggleButtonController> {
  SelectButton({
    required this.children,
    this.onPressed,
    this.onPresseds,
    this.isSelected,
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
    required this.config,
    super.key,
  })  : onmain = (onPressed != null && config.normal == false)
            ? onPressed
            : onPresseds,
        assert(
            (config.normal == true) ? isSelected == null : true,
            'Quando normal está ativado\n'
            'isSelected e onPresseds não pode ser null'),
        assert(
            (config.normal == true) ? onPresseds == null : true,
            'Quando normal está ativado\n'
            'onPresseds e isSelected não pode ser null');

  final ToggleButtonConfig config;

  final void Function(int)? onmain;

  final List<bool>? isSelected;

  /// O callback é chamado quando um botão é tocado.
  ///
  /// O parâmetro index do callback é o índice do botão que está
  /// tocado ou ativado de outra forma.
  ///
  /// Quando o retorno de chamada for nulo, todos os botões de alternância serão desabilitados.
  final void Function(int)? onPresseds;

  /// O callback é chamado quando um botão é tocado.
  ///
  /// O parâmetro index do callback é o índice do botão que está
  /// tocado ou ativado de outra forma.
  ///
  /// Quando o retorno de chamada for nulo, todos os botões de alternância serão desabilitados.
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

  /// Define o tamanho do botão.
  ///
  /// Normalmente usado para restringir o tamanho mínimo do botão.
  ///
  /// Se esta propriedade for nula, então
  /// BoxConstraints(minWidth: 48.0, minHeight: 48.0) é usado.
  final BoxConstraints? constraints;

  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    Get.put(
      ToggleButtonController(
        children: children,
        initvalue: config.initvalue,
      ),
    );

    // Get.put(
    //   ToggleButtonController(
    //     children: children,
    //     initvalue: initvalue,
    //   ),
    //   permanent: true,
    // );

    return (config.animation != null)
        ? AnimatedContainer(
            key: Key((#AnimatedContainer).toString()),
            duration: config.animation!.duration,
            alignment: config.animation!.alignment,
            color: config.animation!.color,
            decoration: config.animation!.decoration,
            foregroundDecoration: config.animation!.foregroundDecoration,
            width: config.animation!.width,
            height: config.animation!.height,
            constraints: config.animation!.constraints,
            transformAlignment: config.animation!.transformAlignment,
            curve: config.animation!.curve,
            clipBehavior: config.animation!.clipBehavior,
            onEnd: config.animation!.onEnd,
            margin: config.animation!.margin,
            transform: config.animation!.transform,
            padding: config.animation!.padding,
            child: Obx(() => ToggleButtons(
                  key: Key((#ToggleButtons).toString()),
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
                  isSelected:
                      config.normal ? isSelected! : controller.isSelected,
                  onPressed: (index) {
                    controller.onPressed(index);
                    onmain!(index);
                  },
                  mouseCursor: mouseCursor,
                  children: children,
                )),
          )
        : Obx(() => ToggleButtons(
              key: Key((#ToggleButtons).toString()),
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
              isSelected: config.normal ? isSelected! : controller.isSelected,
              onPressed: (index) {
                controller.onPressed(index);
                onmain!(index);
              },
              mouseCursor: mouseCursor,
              children: children,
            ));
  }
}

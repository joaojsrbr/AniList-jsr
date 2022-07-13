// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable

import 'package:ani_search/app/modules/home/widgets/select_button/controller/controller.dart';
import 'package:ani_search/app/modules/home/widgets/select_button/models/select_button_config_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:ani_search/app/modules/home/widgets/select_button/models/select_button_config_model.dart';

class SelectButton extends GetView<SelectButtonController> {
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

  final SelectButtonConfig config;

  final void Function(int)? onmain;

  final List<bool>? isSelected;

  /// O callback é chamado quando um botão é tocado.
  ///
  /// O parâmetro index do callback é o índice do botão que está
  /// tocado ou ativado de outra forma.
  ///
  /// Somente se o paramentro normal e isSelected estiver ativado
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
    Get.put<SelectButtonController>(
      SelectButtonController(
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

    return GetBuilder<SelectButtonController>(
      id: #SelectButton,
      assignId: true,
      autoRemove: false,
      didChangeDependencies: (state) =>
          controller.didChangeDependencies(state, config),
      builder: (controller) {
        return ToggleButtons(
          key: controller.stringkey(key, 'SelectButton'),
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
        );
      },
    );
  }
}

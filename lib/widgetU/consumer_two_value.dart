import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsummerPerson<A, B> extends StatelessWidget {
  const ConsummerPerson({
    super.key,
    required this.builder,
  });
  final Widget Function(BuildContext, A value, B value1, Widget) builder;
  @override
  Widget build(BuildContext context) {
    return Consumer2<A, B>(
      builder: (context, value, value2, child) {
        return builder(context, value, value2, child!);
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3(
    this.first,
    this.three,
    this.second, {
    super.key,
    required this.builder,
    this.child,
  });

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final ValueListenable<C> three;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, C c, Widget child)
      builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (_, b, __) {
            return ValueListenableBuilder<C>(
              valueListenable: three,
              builder: (context, c, _) {
                return builder(context, a, b, c, child!);
              },
            );
          },
        );
      },
    );
  }
}

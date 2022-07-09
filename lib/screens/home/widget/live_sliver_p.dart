// ignore_for_file: library_private_types_in_public_api

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:flutter/material.dart';

import 'helpers/animate_if_visible.dart';
import 'helpers/options.dart';
import 'helpers/utils.dart' as utils;

const Duration _kDuration = Duration(milliseconds: 250);

class LiveSliverListP<A> extends StatefulWidget {
  const LiveSliverListP({
    required this.itemBuilder,
    this.itemCount = 0,
    required this.controller,
    this.visibleFraction = 0.025,
    this.reAnimateOnVisibility = false,
    this.semanticIndexOffset = 0,
    this.delay = Duration.zero,
    this.lista,
    this.showItemInterval = _kDuration,
    this.showItemDuration = _kDuration,
    super.key,
  }) : assert(itemCount >= 0);

  LiveSliverListP.options({
    required this.itemBuilder,
    this.semanticIndexOffset = 0,
    this.lista,
    this.itemCount = 0,
    required this.controller,
    required LiveOptions options,
    super.key,
  })  : delay = options.delay,
        showItemInterval = options.showItemInterval,
        showItemDuration = options.showItemDuration,
        visibleFraction = options.visibleFraction,
        reAnimateOnVisibility = options.reAnimateOnVisibility,
        assert(itemCount >= 0);

  final List<A>? lista;

  /// Start animation after (default zero)
  final Duration delay;

  /// Show each item through
  final Duration showItemInterval;

  final int semanticIndexOffset;

  /// Animation duration
  final Duration showItemDuration;

  /// A fraction in the range \[0, 1\] that represents what proportion of the
  /// widget is visible (assuming rectangular bounding boxes).
  ///
  /// 0 means not visible; 1 means fully visible.
  final double visibleFraction;

  /// Hide the element when it approaches the
  /// frame of the screen so that in the future,
  /// when it falls into the visibility range - reproduce animation again
  final bool reAnimateOnVisibility;

  /// It is necessary in order to
  /// find out in which direction the
  /// widget scrolls in order to play
  ///  the animation in the corresponding direction
  final ScrollController controller;

  /// Called, as needed, to build list item widgets.
  final Widget Function(BuildContext, int, Animation<double>, Media)
      itemBuilder;

  /// The number of items the list will start with.
  ///
  /// The appearance of the initial items is not animated. They
  /// are created, as needed, by [itemBuilder] with an animation parameter
  /// of [kAlwaysCompleteAnimation].
  final int itemCount;

  @override
  _LiveSliverListState createState() => _LiveSliverListState();
}

class _LiveSliverListState extends State<LiveSliverListP>
    with TickerProviderStateMixin<LiveSliverListP> {
  final String _keyPrefix = utils.createCryptoRandomString();

  Widget _itemBuilder(BuildContext context, int itemIndex) => AnimateIfVisible(
        key: Key('$_keyPrefix.$itemIndex'),
        duration: widget.showItemDuration,
        visibleFraction: widget.visibleFraction,
        reAnimateOnVisibility: widget.reAnimateOnVisibility,
        builder: (context, animation) => widget.itemBuilder(
          context,
          itemIndex,
          animation,
          widget.lista![itemIndex],
        ),
      );

  @override
  Widget build(BuildContext context) => AnimateIfVisibleWrapper(
        controller: widget.controller,
        delay: widget.delay,
        showItemInterval: widget.showItemInterval,
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            _itemBuilder,
            semanticIndexOffset: widget.semanticIndexOffset,
            childCount: (widget.lista != null)
                ? widget.lista!.length
                : widget.itemCount,
          ),
        ),
      );
}

class LiveSliverGridP<B> extends StatefulWidget {
  const LiveSliverGridP({
    this.lista,
    required this.itemBuilder,
    required this.gridDelegate,
    this.itemCount = 0,
    required this.controller,
    this.visibleFraction = 0.025,
    this.reAnimateOnVisibility = false,
    this.delay = Duration.zero,
    this.showItemInterval = _kDuration,
    this.showItemDuration = _kDuration,
    super.key,
  }) : assert(itemCount >= 0);

  LiveSliverGridP.options({
    this.lista,
    required this.itemBuilder,
    required this.gridDelegate,
    this.itemCount = 0,
    required this.controller,
    required LiveOptions options,
    super.key,
  })  : delay = options.delay,
        showItemInterval = options.showItemInterval,
        showItemDuration = options.showItemDuration,
        visibleFraction = options.visibleFraction,
        reAnimateOnVisibility = options.reAnimateOnVisibility,
        assert(itemCount >= 0);

  final List<B>? lista;

  /// Start animation after (default zero)
  final Duration delay;

  /// Show each item through
  final Duration showItemInterval;

  /// Animation duration
  final Duration showItemDuration;

  /// A fraction in the range \[0, 1\] that represents what proportion of the
  /// widget is visible (assuming rectangular bounding boxes).
  ///
  /// 0 means not visible; 1 means fully visible.
  final double visibleFraction;

  /// Hide the element when it approaches the
  /// frame of the screen so that in the future,
  /// when it falls into the visibility range - reproduce animation again
  final bool reAnimateOnVisibility;

  /// It is necessary in order to
  /// find out in which direction the
  /// widget scrolls in order to play
  ///  the animation in the corresponding direction
  final ScrollController controller;

  /// Called, as needed, to build list item widgets.
  final Widget Function(BuildContext, int, Animation<double>, Media)
      itemBuilder;

  /// The number of items the list will start with.
  ///
  /// The appearance of the initial items is not animated. They
  /// are created, as needed, by [itemBuilder] with an animation parameter
  /// of [kAlwaysCompleteAnimation].
  final int itemCount;

  /// A delegate that controls the layout of the children within the [GridView].
  ///
  /// The [GridView], [GridView.builder], and [GridView.custom]
  /// constructors let you specify this
  /// delegate explicitly. The other constructors create a [gridDelegate]
  /// implicitly.
  final SliverGridDelegate gridDelegate;

  @override
  _LiveSliverGridState createState() => _LiveSliverGridState();
}

class _LiveSliverGridState extends State<LiveSliverGridP>
    with TickerProviderStateMixin<LiveSliverGridP> {
  final String _keyPrefix = utils.createCryptoRandomString();

  // @override
  // void initState() {
  //   widget.controller.jumpTo(0.0);
  //   super.initState();
  // }

  Widget _itemBuilder(BuildContext context, int itemIndex) => AnimateIfVisible(
        key: Key('$_keyPrefix.$itemIndex'),
        duration: widget.showItemDuration,
        visibleFraction: widget.visibleFraction,
        reAnimateOnVisibility: widget.reAnimateOnVisibility,
        builder: (context, animation) => widget.itemBuilder(
            context, itemIndex, animation, widget.lista![itemIndex]),
      );

  @override
  Widget build(BuildContext context) => AnimateIfVisibleWrapper(
        controller: widget.controller,
        delay: widget.delay,
        showItemInterval: widget.showItemInterval,
        child: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            _itemBuilder,
            childCount: (widget.lista != null)
                ? widget.lista!.length
                : widget.itemCount,
          ),
          gridDelegate: widget.gridDelegate,
        ),
      );
}

import 'dart:async';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/screens/details/models/list_type_widgets.dart';
import 'package:ani_search/screens/details/utils/parse_html_to_string.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class SingleChildScrollW extends StatefulWidget {
  final Media? dataProvider;
  final ExpandableController? expandableController;
  final ScrollController parentController;
  const SingleChildScrollW({
    super.key,
    required this.parentController,
    this.dataProvider,
    this.expandableController,
  });

  @override
  State<SingleChildScrollW> createState() => _SingleChildScrollWState();
}

class _SingleChildScrollWState extends State<SingleChildScrollW>
    with AutomaticKeepAliveClientMixin<SingleChildScrollW> {
  @override
  bool get wantKeepAlive => false;

  late ScrollPhysics ph;
  // late ScrollController _controller2;
  late ScrollController _scrollController;
  // late LinkedScrollControllerGroup _controllerGroup;
  @override
  void initState() {
    super.initState();
    // _controllerGroup = LinkedScrollControllerGroup();

    _scrollController = ScrollController();

    // _controller2 = _controllerGroup.addAndGet();
    // _scrollController = _controllerGroup.addAndGet();
    // widget.parentController = _controllerGroup.addAndGet();

    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels;
      var maxOuterPos = widget.parentController.position.maxScrollExtent;
      var currentOutPos = widget.parentController.position.pixels;

      if (innerPos >= 0 && currentOutPos < maxOuterPos) {
        //print("parent pos " + currentOutPos.toString() + "max parent pos " + maxOuterPos.toString());
        Timer(
            const Duration(milliseconds: 1),
            () => widget.parentController.position
                .jumpTo(innerPos + currentOutPos));
      } else {
        var currenParentPos = innerPos + currentOutPos;
        Timer(const Duration(milliseconds: 1),
            () => widget.parentController.position.jumpTo(currenParentPos));
      }
    });

    widget.parentController.addListener(() {
      var currentOutPos = widget.parentController.position.pixels;
      if (currentOutPos <= 0) {
        Timer(const Duration(milliseconds: 1),
            () => _scrollController.position.jumpTo(0));
      }
    });
  }

  void update() {
    setState(() {});
  }

  @override
  void dispose() {
    // _scrollController.removeListener(update);
    // _scrollController.dispose();
    // _controller2.dispose();
    _scrollController.dispose();

    // _controller2.removeListener(update);
    super.dispose();
  }

  // var thirdMap = List<String>, dynamic>{}
  //   ..addAll(cardlistString.map((e) {
  //     final List<String> temp = [];
  //     temp.add(e);
  //     return e;
  //   }))
  //   ..addAll(secondMap);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // if (kDebugMode) {
    //   print(widget.dataProvider?.genres?.first ?? '');
    // }
    return ListView(
      primary: true,
      // controller: _scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      key: UniqueKey(),
      children: [
        Container(
          key: const PageStorageKey('CW'),
          height: MediaQuery.of(context).size.height * .868,
          padding: const EdgeInsets.all(2),
          width: MediaQuery.of(context).size.width * .868,
          // color: Colors.amber,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 50.0,
            ),
            subtitle: ListView(
              // key: UniqueKey(),
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 0, top: 8),
                  child: ExpandablePanel(
                    controller: widget.expandableController,
                    theme: const ExpandableThemeData(
                      useInkWell: false,
                      iconColor: Colors.white,
                    ),
                    header: Text(
                      parseHtmlString(widget.dataProvider!.description ?? ''),
                      maxLines: 7,
                      style: const TextStyle(
                          // backgroundColor: Colors.black,
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                          // fontWeight: FontWeight.w700,
                          ),
                    ),
                    collapsed: Text(
                      parseHtmlString(widget.dataProvider!.description ?? ''),
                      softWrap: true,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: HtmlWidget(
                      widget.dataProvider!.description ?? '',
                      textStyle: const TextStyle(
                        // backgroundColor: Colors.black,

                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        // fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Wrap(
                  // spacing: 0.01,
                  // runSpacing: 0.1,
                  // crossAxisAlignment: WrapCrossAlignment.end,
                  children: listCard(context, widget.dataProvider!),
                )
              ],
            ),
            title: Text(
              widget.dataProvider!.title!.english ??
                  widget.dataProvider!.title!.romaji ??
                  widget.dataProvider!.title!.native ??
                  '',
              style: const TextStyle(
                fontSize: 26,
                // color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

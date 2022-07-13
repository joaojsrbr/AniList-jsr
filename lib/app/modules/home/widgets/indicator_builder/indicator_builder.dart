import 'package:ani_search/app/data/repositories/manga_and_anime_repository.dart';
import 'package:ani_search/app/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

Widget indicatorBuilder(BuildContext context, IndicatorStatus status,
    MangaandAnimeRepository repository) {
  Widget _setbackground(
      bool full, Widget widget, double height, BuildContext context) {
    widget = Container(
      width: double.infinity,
      height: height,
      color: AppColors().background(context),
      alignment: Alignment.center,
      child: widget,
    );
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(
            animating: true,
            radius: 16.0,
          )
        : const CircularProgressIndicator(
            strokeWidth: 2.0,
          );
  }

  bool isSliver = true;
  late Widget widget;
  switch (status) {
    case IndicatorStatus.none:
      widget = Container(height: 0.0);
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      }
      break;
    case IndicatorStatus.loadingMoreBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 0.0),
            height: 30.0,
            width: 30.0,
            child: getIndicator(context),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Carregando..."),
          ),
        ],
      );
      widget = _setbackground(false, widget, 50.0, context);
      break;
    case IndicatorStatus.fullScreenBusying:
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIndicator(context),
        ],
      );
      widget = _setbackground(false, widget, 35.0, context);
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      }
      break;
    case IndicatorStatus.error:
      widget = const Center(
        child: Icon(
          Icons.error,
        ),
      );
      widget = _setbackground(false, widget, 35.0, context);
      widget = GestureDetector(
        onTap: () {
          repository.errorRefresh();
        },
        child: widget,
      );
      break;
    case IndicatorStatus.fullScreenError:
      widget = const Center(
        child: Icon(
          Icons.error,
        ),
      );
      widget = _setbackground(true, widget, double.infinity, context);
      widget = GestureDetector(
        onTap: () {
          repository.errorRefresh();
        },
        child: widget,
      );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      }
      break;
    case IndicatorStatus.noMoreLoad:
      widget = const Center(
        child: Text(
          'NoData',
        ),
      );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      }
      break;
    case IndicatorStatus.empty:
      widget = const Center(
        child: Text(
          'NoData',
        ),
      );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      }
      break;
  }
  return widget;
}

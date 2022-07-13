// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/data/enums/state.dart';

class StateMedia {
  List<Media> tempdata;
  StateEnum stateEnum;
  StateMedia({
    required this.tempdata,
    required this.stateEnum,
  });

  @override
  bool operator ==(covariant StateMedia other) {
    if (identical(this, other)) return true;

    return listEquals(other.tempdata, tempdata) && other.stateEnum == stateEnum;
  }

  @override
  int get hashCode => tempdata.hashCode ^ stateEnum.hashCode;
}

import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/data/api_graphql_pageinfo_model.dart';

class Page {
  String? sTypename;
  PageInfo? pageInfo;
  List<Media>? media;

  Page({this.sTypename, this.pageInfo, this.media});

  Page.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

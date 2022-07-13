import 'package:ani_search/app/data/api_graphql_nodes_model.dart';
import 'package:ani_search/app/data/api_graphql_pageinfo_model.dart';

class Recommendations {
  PageInfo? pageInfo;
  List<Nodes>? nodes;

  Recommendations({this.pageInfo, this.nodes});

  Recommendations.fromJson(Map<String, dynamic> json) {
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    if (json['nodes'] != null) {
      nodes = <Nodes>[];
      json['nodes'].forEach((v) {
        nodes!.add(Nodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    if (nodes != null) {
      data['nodes'] = nodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

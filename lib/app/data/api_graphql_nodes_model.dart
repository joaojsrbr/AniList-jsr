import 'package:ani_search/app/data/api_graphql_mediarecommendation_model.dart';

class Nodes {
  MediaRecommendation? mediaRecommendation;

  Nodes({this.mediaRecommendation});

  Nodes.fromJson(Map<String, dynamic> json) {
    mediaRecommendation = json['mediaRecommendation'] != null
        ? MediaRecommendation.fromJson(json['mediaRecommendation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mediaRecommendation != null) {
      data['mediaRecommendation'] = mediaRecommendation!.toJson();
    }
    return data;
  }
}

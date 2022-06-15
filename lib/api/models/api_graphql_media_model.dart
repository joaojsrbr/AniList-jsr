import 'package:anisearch2/api/models/api_graphql_coverimage_model.dart';
import 'package:anisearch2/api/models/api_graphql_recommendations_model.dart';
import 'package:anisearch2/api/models/api_graphql_startdate_model.dart';
import 'package:anisearch2/api/models/api_graphql_title_model.dart';

class Media {
  String? sTypename;
  String? description;
  int? id;
  String? bannerImage;
  String? status;
  StartDate? startDate;
  StartDate? endDate;
  int? meanScore;
  int? popularity;
  int? favourites;
  String? format;
  String? source;
  List<String>? genres;
  List<String>? synonyms;
  CoverImage? coverImage;
  String? type;
  int? episodes;
  int? idMal;
  Recommendations? recommendations;
  int? averageScore;
  String? countryOfOrigin;
  Title? title;

  Media(
      {this.description,
      this.id,
      this.endDate,
      this.sTypename,
      this.bannerImage,
      this.status,
      this.startDate,
      this.meanScore,
      this.popularity,
      this.favourites,
      this.format,
      this.source,
      this.genres,
      this.synonyms,
      this.coverImage,
      this.type,
      this.recommendations,
      this.episodes,
      this.idMal,
      this.averageScore,
      this.countryOfOrigin,
      this.title});

  Media.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    bannerImage = json['bannerImage'];
    status = json['status'];
    startDate = json['startDate'] != null
        ? StartDate.fromJson(json['startDate'])
        : null;
    recommendations = json['recommendations'] != null
        ? Recommendations.fromJson(json['recommendations'])
        : null;
    meanScore = json['meanScore'];
    description = json['description'];
    endDate =
        json['endDate'] != null ? StartDate.fromJson(json['endDate']) : null;
    popularity = json['popularity'];
    favourites = json['favourites'];
    format = json['format'];
    source = json['source'];
    genres = json['genres'].cast<String>();
    synonyms = json['synonyms'].cast<String>();
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    type = json['type'];
    episodes = json['episodes'];
    idMal = json['idMal'];
    averageScore = json['averageScore'];
    countryOfOrigin = json['countryOfOrigin'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['description'] = description;
    if (recommendations != null) {
      data['recommendations'] = recommendations!.toJson();
    }
    data['id'] = id;
    data['bannerImage'] = bannerImage;
    data['status'] = status;
    if (endDate != null) {
      data['endDate'] = endDate!.toJson();
    }
    if (startDate != null) {
      data['startDate'] = startDate!.toJson();
    }
    data['meanScore'] = meanScore;
    data['popularity'] = popularity;
    data['favourites'] = favourites;
    data['format'] = format;
    data['source'] = source;
    data['genres'] = genres;
    data['description'] = description;
    data['synonyms'] = synonyms;
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['type'] = type;
    data['episodes'] = episodes;
    data['idMal'] = idMal;
    data['averageScore'] = averageScore;
    data['countryOfOrigin'] = countryOfOrigin;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    return data;
  }
}

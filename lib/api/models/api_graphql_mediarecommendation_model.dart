import 'package:anisearch2/api/models/api_graphql_coverimage_model.dart';
import 'package:anisearch2/api/models/api_graphql_startdate_model.dart';
import 'package:anisearch2/api/models/api_graphql_title_model.dart';

class MediaRecommendation {
  int? idMal;
  int? id;
  String? type;
  int? episodes;
  String? description;
  int? meanScore;
  int? popularity;
  int? favourites;
  String? format;
  String? source;
  List<String>? genres;
  String? status;
  StartDate? endDate;
  StartDate? startDate;
  List<String>? synonyms;
  CoverImage? coverImage;
  String? bannerImage;
  Title? title;

  MediaRecommendation(
      {this.idMal,
      this.id,
      this.type,
      this.episodes,
      this.description,
      this.meanScore,
      this.popularity,
      this.favourites,
      this.format,
      this.source,
      this.genres,
      this.status,
      this.endDate,
      this.startDate,
      this.synonyms,
      this.coverImage,
      this.bannerImage,
      this.title});

  MediaRecommendation.fromJson(Map<String, dynamic> json) {
    idMal = json['idMal'];
    id = json['id'];
    type = json['type'];
    episodes = json['episodes'];
    description = json['description'];
    meanScore = json['meanScore'];
    popularity = json['popularity'];
    favourites = json['favourites'];
    format = json['format'];
    source = json['source'];
    genres = json['genres'].cast<String>();
    status = json['status'];
    endDate =
        json['endDate'] != null ? StartDate.fromJson(json['endDate']) : null;
    startDate = json['startDate'] != null
        ? StartDate.fromJson(json['startDate'])
        : null;
    synonyms = json['synonyms'].cast<String>();
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    bannerImage = json['bannerImage'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMal'] = idMal;
    data['id'] = id;
    data['type'] = type;
    data['episodes'] = episodes;
    data['description'] = description;
    data['meanScore'] = meanScore;
    data['popularity'] = popularity;
    data['favourites'] = favourites;
    data['format'] = format;
    data['source'] = source;
    data['genres'] = genres;
    data['status'] = status;
    if (endDate != null) {
      data['endDate'] = endDate!.toJson();
    }
    if (startDate != null) {
      data['startDate'] = startDate!.toJson();
    }
    data['synonyms'] = synonyms;
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['bannerImage'] = bannerImage;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    return data;
  }
}

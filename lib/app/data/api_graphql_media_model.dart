// ignore_for_file: public_member_api_docs, sort_constructors_first, body_might_complete_normally_nullable
import 'package:ani_search/app/data/api_graphql_title_model.dart';
import 'package:flutter/foundation.dart';

import 'package:ani_search/app/data/api_graphql_coverimage_model.dart';
import 'package:ani_search/app/data/api_graphql_recommendations_model.dart';
import 'package:ani_search/app/data/api_graphql_startdate_model.dart';

extension Equa on Media {
  bool? equa(List<Media> other) {
    if (other.isNotEmpty) {
      for (var i in other) {
        return i == this;
      }
      return null;
    } else {
      return false;
    }
  }
}

/* 
{
  "data": {
      "media": [
        {
          "description": "Everyone has a part of themselves they cannot show to anyone else.\n<br><br>\nAt a time when all nations of the world were involved in a fierce war of information happening behind closed doors, Ostania and Westalis had been in a state of cold war against one another for decades. The Westalis Intelligence Services' Eastern-Focused Division (WISE) sends their most talented spy, \"Twilight,\" on a top-secret mission to investigate the movements of Donovan Desmond, the chairman of Ostania's National Unity Party, who is threatening peace efforts between the two nations.\n<br><br>\nThis mission is known as \"Operation Strix.\" It consists of \"putting together a family in one week in order to infiltrate social gatherings organized by the elite school that Desmond's son attends.\" <br><br>\n\"Twilight\" takes on the identity of psychiatrist Loid Forger and starts looking for family members. But Anya, the daughter he adopts, turns out to have the ability to read people's minds, while his wife, Yor, is an assassin! With it being in each of their own interests to keep these facts hidden, they start living together while concealing their true identities from one another. <br>\nWorld peace is now in the hands of this brand-new family as they embark on an adventure full of surprises.\n<br><br>\n(Source: Crunchyroll)",
          "id": 140960,
          "bannerImage": "https://s4.anilist.co/file/anilistcdn/media/anime/banner/140960-Z7xSvkRxHKfj.jpg",
          "status": "FINISHED",
          "endDate": {
            "year": 2022,
            "month": 6,
            "day": 25
          },
          "startDate": {
            "year": 2022,
            "month": 4,
            "day": 9
          },
          "meanScore": 88,
          "popularity": 192537,
          "favourites": 14022,
          "format": "TV",
          "source": "MANGA",
          "genres": [
            "Action",
            "Comedy",
            "Slice of Life",
            "Supernatural"
          ],
          "synonyms": [
            "SxF",
            "스파이 패밀리",
            "间谍过家家",
            "Семья шпиона",
            "سباي إكس فاميلي"
          ],
          "coverImage": {
            "large": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx140960-vN39AmOWrVB5.jpg",
            "extraLarge": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx140960-vN39AmOWrVB5.jpg",
            "medium": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/small/bx140960-vN39AmOWrVB5.jpg",
            "color": "#c9f1f1"
          },
          "type": "ANIME",
          "episodes": 12,
          "recommendations": {
            "pageInfo": {
              "total": 500,
              "currentPage": 1,
              "lastPage": 500,
              "hasNextPage": true,
              "perPage": 1
            },
            "nodes": [
              {
                "mediaRecommendation": {
                  "idMal": 37999,
                  "id": 101921,
                  "type": "ANIME",
                  "episodes": 12,
                  "description": "Known for being both brilliant and powerful, Miyuki Shirogane and Kaguya Shinomiya lead the illustrious Shuchiin Academy as near equals. And everyone thinks they’d make a great couple. Pride and arrogance are in ample supply, so the only logical move is to trick the other into instigating a date! Who will come out on top in this psychological war where the first move is the only one that matters?\n<br><br>\n(Source: Aniplex)",
                  "meanScore": 83,
                  "popularity": 310993,
                  "favourites": 18173,
                  "format": "TV",
                  "source": "MANGA",
                  "genres": [
                    "Comedy",
                    "Psychological",
                    "Romance",
                    "Slice of Life"
                  ],
                  "status": "FINISHED",
                  "endDate": {
                    "year": 2019,
                    "month": 3,
                    "day": 30
                  },
                  "startDate": {
                    "year": 2019,
                    "month": 1,
                    "day": 12
                  },
                  "synonyms": [
                    "Kaguya Wants to be Confessed To: The Geniuses' War of Love and Brains",
                    "קאגויה סאמה",
                    "辉夜大小姐想让我告白～天才们的恋爱头脑战～",
                    "辉夜姬想让人告白",
                    "辉夜姬想让人告白～天才们的恋爱头脑战～",
                    "辉告",
                    "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
                    "Kaguya-sama : L'Amour est une guerre",
                    "สารภาพรักกับคุณคางุยะซะดีๆ ~สงครามประสาทความรักของเหล่าอัจฉริยะ~",
                    "Кагуя хочет, чтобы ей признались: Война любви и разума гениев"
                  ],
                  "coverImage": {
                    "large": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/medium/bx101921-VvdGQy1ZySYf.jpg",
                    "color": "#e45086",
                    "extraLarge": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx101921-VvdGQy1ZySYf.jpg",
                    "medium": "https://s4.anilist.co/file/anilistcdn/media/anime/cover/small/bx101921-VvdGQy1ZySYf.jpg",
                    "__typename": "MediaCoverImage"
                  },
                  "bannerImage": "https://s4.anilist.co/file/anilistcdn/media/anime/banner/101921-GgvvFhlNhzlF.jpg",
                  "title": {
                    "english": "Kaguya-sama: Love is War",
                    "romaji": "Kaguya-sama wa Kokurasetai: Tensaitachi no Renai Zunousen",
                    "native": "かぐや様は告らせたい～天才たちの恋愛頭脳戦～"
                  }
                }
              }
            ]
          },
          "idMal": 50265,
          "averageScore": 88,
          "countryOfOrigin": "JP",
          "title": {
            "english": "SPY x FAMILY",
            "romaji": "SPY×FAMILY",
            "native": "SPY×FAMILY"
          }
        }
      ]
    }
  }
}
*/

class Media {
  String? sTypename;
  String? description;
  int? id;
  String? bannerImage;
  String? status;
  StartDate? startDate;
  StartDate? endDate;

  int? meanScore;
  String? idr;
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
      this.idr,
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.sTypename == sTypename &&
        other.description == description &&
        other.id == id &&
        other.bannerImage == bannerImage &&
        other.status == status &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.meanScore == meanScore &&
        other.idr == idr &&
        other.popularity == popularity &&
        other.favourites == favourites &&
        other.format == format &&
        other.source == source &&
        listEquals(other.genres, genres) &&
        listEquals(other.synonyms, synonyms) &&
        other.coverImage == coverImage &&
        other.type == type &&
        other.episodes == episodes &&
        other.idMal == idMal &&
        other.recommendations == recommendations &&
        other.averageScore == averageScore &&
        other.countryOfOrigin == countryOfOrigin &&
        other.title == title;
  }

  @override
  int get hashCode {
    return sTypename.hashCode ^
        description.hashCode ^
        id.hashCode ^
        bannerImage.hashCode ^
        status.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        meanScore.hashCode ^
        idr.hashCode ^
        popularity.hashCode ^
        favourites.hashCode ^
        format.hashCode ^
        source.hashCode ^
        genres.hashCode ^
        synonyms.hashCode ^
        coverImage.hashCode ^
        type.hashCode ^
        episodes.hashCode ^
        idMal.hashCode ^
        recommendations.hashCode ^
        averageScore.hashCode ^
        countryOfOrigin.hashCode ^
        title.hashCode;
  }
}

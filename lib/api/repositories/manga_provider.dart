// ignore_for_file: unused_local_variable

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/models/api_graphql_model.dart';
import 'package:ani_search/api/models/api_graphql_pageinfo_model.dart';
import 'package:ani_search/api/models/api_graphql_query.dart';
import 'package:ani_search/api/models/api_graphql_url.dart';
import 'package:ani_search/api/models/api_graphql_variables.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class MangaProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Media> _manga = [];
  List<Media> _mangap = [];
  PageInfo _pageInfoM = PageInfo();
  PageInfo _pageInfoMp = PageInfo();

  PageInfo get pageInfoM => _pageInfoM;
  PageInfo get pageInfoMp => _pageInfoMp;
  UnmodifiableListView<Media> get mangap => UnmodifiableListView(_mangap);
  UnmodifiableListView<Media> get manga => UnmodifiableListView(_manga);
  bool get isLoading => _isLoading;

  Future<void> Function({
    int page,
    int perPage,
    List<String> sort,
    dynamic type,
  }) get getHomeManga => _getHomeManga;

  MangaProvider() {
    _getHomeManga();
    _getHomeMangaP();
  }

  Future<void> _getHomeMangaP({
    List<String> sort = const ["POPULARITY_DESC"],
    type = 'MANGA',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    _isLoading = true;
    PageInfo temppageInfo;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesG(
        sort: sort,
        type: type,
        page: page,
        perPage: perPage,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    _mangap = tempData;

    temppageInfo = repositories.page!.pageInfo!;

    _pageInfoMp = temppageInfo;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> getMore({
    required List<String> sort,
    required type,
    int perPage = 25,
    int page = 0,
    required bool popula,
  }) async {
    List<Media> tempData = [];

    _isLoading = true;

    PageInfo temppageInfo;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesG(
        sort: sort,
        type: type,
        page: page,
        perPage: perPage,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    // * ApiGraphQLModel
    ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);

    // * List<Media>
    tempData = _returnMedia(repositories.page!.media!);

    if (popula == true) {
      for (Media i in tempData) {
        // * Check mangap == tempData
        if (i.equa(mangap) == false) {
          if (kDebugMode) {
            // * print result
            print(
                'title: ${i.title!.english ?? i.title!.romaji ?? i.title!.native} -- id: ${i.id} -- igual: ${i.equa(mangap)}');
          }
          // * add to list
          _mangap.add(i);
        }
      }
    } else {
      for (Media i in tempData) {
        // * Check manga == tempData
        if (i.equa(manga) == false) {
          if (kDebugMode) {
            // * print result
            print(
                'title: ${i.title!.english ?? i.title!.romaji ?? i.title!.native} -- id: ${i.id} -- igual: ${i.equa(manga)}');
          }
          // * add to list
          _manga.add(i);
        }
      }
    }

    temppageInfo = repositories.page!.pageInfo!;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> _getHomeManga({
    List<String> sort = const ["TRENDING_DESC"],
    type = 'MANGA',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    _isLoading = true;
    PageInfo temppageInfo;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesG(
        sort: sort,
        type: type,
        page: page,
        perPage: perPage,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    _manga = tempData;

    temppageInfo = repositories.page!.pageInfo!;

    _pageInfoM = temppageInfo;

    _isLoading = false;

    notifyListeners();
  }
}

var uuid = const Uuid(options: {'grng': UuidUtil.cryptoRNG});
List<Media> _returnMedia(List<Media>? media) {
  return media!
      .map(
        (e) => Media(
          idr: uuid.v4(),
          sTypename: e.sTypename,
          description: e.description,
          bannerImage: e.bannerImage,
          idMal: e.idMal,
          averageScore: e.averageScore,
          countryOfOrigin: e.countryOfOrigin,
          title: e.title,
          popularity: e.popularity,
          id: e.id,
          coverImage: e.coverImage,
          type: e.type,
          favourites: e.favourites,
          genres: e.genres,
          synonyms: e.synonyms,
          startDate: e.startDate,
          source: e.source,
          meanScore: e.meanScore,
          status: e.status,
          format: e.format,
          episodes: e.episodes,
          recommendations: e.recommendations,
        ),
      )
      .toList();
}

GraphQLClient _client(Link link) {
  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}

// ignore_for_file: unused_local_variable

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/models/api_graphql_model.dart';
import 'package:ani_search/api/models/api_graphql_pageinfo_model.dart';
import 'package:ani_search/api/models/api_graphql_query.dart';
import 'package:ani_search/api/models/api_graphql_url.dart';
import 'package:ani_search/api/models/api_graphql_variables.dart';

class AnimeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Media> _anime = [];
  List<Media> _animep = [];
  PageInfo _pageInfoA = PageInfo();
  PageInfo _pageInfoAp = PageInfo();

  PageInfo get pageInfoA => _pageInfoA;
  PageInfo get pageInfoAp => _pageInfoAp;
  UnmodifiableListView<Media> get anime => UnmodifiableListView(_anime);
  UnmodifiableListView<Media> get animep => UnmodifiableListView(_animep);
  bool get isLoading => _isLoading;

  Future<void> Function(
      {int page,
      int perPage,
      List<String> sort,
      dynamic type}) get getHomeAnime => _getHomeAnime;

  AnimeProvider() {
    _getHomeAnime();
    _getHomeAnimep();
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
      for (var i in tempData) {
        // * Check animep == tempData
        if (i.equa(animep) == false) {
          if (kDebugMode) {
            // * print result
            print(
                'title: ${i.title!.english ?? i.title!.romaji ?? i.title!.native} -- id: ${i.id} -- ${i.equa(animep)}');
          }
          // * add Media to list
          _animep.add(i);
        }
      }
    } else {
      for (var i in tempData) {
        // * Check anime == tempData
        if (i.equa(anime) == false) {
          if (kDebugMode) {
            // * print result
            print(
                'title: ${i.title!.english ?? i.title!.romaji ?? i.title!.native} -- id: ${i.id} -- ${i.equa(anime)}');
          }
          // * add Media to list
          _anime.add(i);
        }
      }
    }

    temppageInfo = repositories.page!.pageInfo!;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _getHomeAnimep({
    List<String> sort = const ["POPULARITY_DESC"],
    type = 'ANIME',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    PageInfo temppageInfo;
    _isLoading = true;

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

    temppageInfo = repositories.page!.pageInfo!;

    _pageInfoAp = temppageInfo;

    _animep = tempData;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> _getHomeAnime({
    List<String> sort = const ["TRENDING_DESC"],
    type = 'ANIME',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    PageInfo temppageInfo;
    _isLoading = true;

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

    temppageInfo = repositories.page!.pageInfo!;

    _pageInfoA = temppageInfo;

    _anime = tempData;

    _isLoading = false;

    notifyListeners();
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
}

GraphQLClient _client(Link link) {
  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}

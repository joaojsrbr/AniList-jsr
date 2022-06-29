// ignore_for_file: unused_local_variable, unused_field

import 'dart:collection';

import 'package:ani_search/api/models/api_graphql_model.dart';
import 'package:ani_search/api/models/api_graphql_query.dart';
import 'package:ani_search/api/models/api_graphql_url.dart';
import 'package:ani_search/api/models/api_graphql_variables.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../models/api_graphql_media_model.dart';
import '../models/api_graphql_pageinfo_model.dart';

class SearchProvider extends ChangeNotifier {
  Media _searchdetails = Media();
  List<Media> _searchlistsu = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Media get searchdetails => _searchdetails;
  UnmodifiableListView<Media> get searchListSu =>
      UnmodifiableListView(_searchlistsu);
  // List<Media> get searchListSu => _searchlistsu;

  Future<void> searchDataSu({
    int perPage = 25,
    int page = 0,
    required String query,
  }) async {
    List<Media> tempData = [];
    _isLoading = true;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesS(
        page: page,
        perPage: perPage,
        search: query,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    var repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    _searchlistsu = tempData;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> searchbyID({required int id}) async {
    List<Media> tempData = [];
    _isLoading = true;
    PageInfo temppageInfo;
    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesByID(
        id: id,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    _searchdetails = tempData.first;

    temppageInfo = repositories.page!.pageInfo!;

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

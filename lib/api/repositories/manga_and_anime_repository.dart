// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'package:ani_search/api/models/api_graphql_model.dart';
import 'package:ani_search/api/models/api_graphql_query.dart';
import 'package:ani_search/api/models/api_graphql_url.dart';
import 'package:ani_search/api/models/api_graphql_variables.dart';

var uuid = const Uuid(options: {'grng': UuidUtil.cryptoRNG});

class MangaandAnimeRepository extends LoadingMoreBase<Media> {
  MangaandAnimeRepository({
    required this.sorts,
    required this.type,
    required this.perPage,
    required this.page,
    required this.manga,
  });

  bool manga;
  String type;
  int perPage;
  int page;
  String sorts;
  bool _hasMore = true;

  bool forceRefresh = false;

  @override
  bool get hasMore => super.hasMore;
  // @override
  // bool get hasMore => (_hasMore && length < 25) || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    page = 1;

    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadMore() {
    page += 1;
    return super.loadMore();
  }

  bool isSuccess = false;
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    List<Media> tempData = [];

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesG(
        sort: [sorts],
        type: type,
        page: page,
        perPage: perPage,
      ),
    );

    final QueryResult result = await _client(apiHttpURL).query(options);

    ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    try {
      for (final Media item in tempData) {
        if (item.idr != null && !contains(item) && hasMore) {
          add(item);

          if (kDebugMode) {
            print(item.title!.english ??
                item.title!.romaji ??
                item.title!.native);
          }
        }
      }
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      if (kDebugMode) {
        print(exception);
        print(stack);
      }
    }

    return isSuccess;
  }
}

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

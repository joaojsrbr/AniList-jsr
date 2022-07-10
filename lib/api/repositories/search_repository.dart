// ignore_for_file: prefer_final_fields

import 'package:ani_search/api/models/api_graphql_media_model.dart';
import 'package:ani_search/api/models/api_graphql_model.dart';
import 'package:ani_search/api/models/api_graphql_query.dart';
import 'package:ani_search/api/models/api_graphql_url.dart';
import 'package:ani_search/api/models/api_graphql_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class SearchRepository extends LoadingMoreBase<Media> {
  SearchRepository({
    this.perPage = 25,
    this.page = 0,
    this.result = false,
    this.query,
    this.manga = true,
  });

  bool result;
  bool manga;
  bool _hasMore = true;

  int perPage;
  int page;
  String? query;

  @override
  bool get hasMore => (_hasMore && length < 25);

  bool isSuccess = false;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    List<Media> tempData = [];
    if (!result) {
      // final QueryOptions options = QueryOptions(
      //   document: gql(queryRes),
      //   variables: variablesS(
      //     page: page,
      //     perPage: perPage,
      //     search: query,
      //   ),
      // );

      final QueryOptions options = QueryOptions(
        document: gql(queryRes),
        variables: variablesG(
          sort: ['TRENDING_DESC'],
          type: manga ? 'MANGA' : 'ANIME',
          page: page,
          perPage: perPage,
        ),
      );
      final QueryResult result = await _client(apiHttpURL).query(options);

      var repositories = ApiGraphQLModel.fromJson(result.data!);

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
    } else {
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
    }
    return isSuccess;
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

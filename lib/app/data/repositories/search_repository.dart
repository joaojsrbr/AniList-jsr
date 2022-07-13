// ignore_for_file: prefer_final_fields, unused_local_variable

import 'package:ani_search/app/data/api_graphql_media_model.dart';
import 'package:ani_search/app/data/api_graphql_model.dart';
import 'package:ani_search/app/core/values/api_graphql_query.dart';
import 'package:ani_search/app/core/values/api_graphql_url.dart';
import 'package:ani_search/app/core/values/api_graphql_variables.dart';
import 'package:ani_search/app/data/api_graphql_state.dart';
import 'package:ani_search/app/data/enums/state.dart';
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

  StateMedia tempData = StateMedia(stateEnum: StateEnum.start, tempdata: []);

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    tempData.stateEnum = StateEnum.start;
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

      // late QueryResult result;
      late QueryResult result;
      late ApiGraphQLModel repositories;

      try {
        tempData.stateEnum = StateEnum.processing;
        QueryResult result = await _client(apiHttpURL).query(options);
        ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);
        tempData.tempdata = _returnMedia(repositories.page!.media!);
      } catch (exception, stack) {
        tempData.stateEnum = StateEnum.error;
        // isSuccess = false;
        if (kDebugMode) {
          print(exception);
          print(stack);
        }
      }

      // var repositories = ApiGraphQLModel.fromJson(result.data!);

      // tempData = _returnMedia(repositories.page!.media!);

      try {
        for (final Media item in tempData.tempdata) {
          if (item.idr != null && !contains(item) && hasMore) {
            add(item);

            if (kDebugMode) {
              print(item.title!.english ??
                  item.title!.romaji ??
                  item.title!.native);
            }
          }
        }
        tempData.stateEnum = StateEnum.end;
      } catch (exception, stack) {
        tempData.stateEnum = StateEnum.error;
        if (kDebugMode) {
          print(exception);
          print(stack);
        }
      }
      switch (tempData.stateEnum) {
        case StateEnum.start:
          isSuccess = false;
          break;
        case StateEnum.processing:
          isSuccess = false;
          break;
        case StateEnum.end:
          isSuccess = true;
          break;
        case StateEnum.error:
          isSuccess = false;
          break;
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

      // final QueryResult result = await _client(apiHttpURL).query(options);

      // var repositories = ApiGraphQLModel.fromJson(result.data!);

      // tempData = _returnMedia(repositories.page!.media!);

      late QueryResult result;
      late ApiGraphQLModel repositories;

      try {
        tempData.stateEnum = StateEnum.processing;
        QueryResult result = await _client(apiHttpURL).query(options);
        ApiGraphQLModel repositories = ApiGraphQLModel.fromJson(result.data!);
        tempData.tempdata = _returnMedia(repositories.page!.media!);
      } catch (exception, stack) {
        tempData.stateEnum = StateEnum.error;
        // isSuccess = false;
        if (kDebugMode) {
          print(exception);
          print(stack);
        }
      }

      try {
        for (final Media item in tempData.tempdata) {
          if (item.idr != null && !contains(item) && hasMore) {
            add(item);

            if (kDebugMode) {
              print(
                  'title: ${item.title!.english ?? item.title!.romaji ?? item.title!.native} - id: ${item.id}');
            }
          }
        }
        tempData.stateEnum = StateEnum.end;
      } catch (exception, stack) {
        tempData.stateEnum = StateEnum.error;
        if (kDebugMode) {
          print(exception);
          print(stack);
        }
      }
      switch (tempData.stateEnum) {
        case StateEnum.start:
          isSuccess = false;
          break;
        case StateEnum.processing:
          isSuccess = false;
          break;
        case StateEnum.end:
          isSuccess = true;
          break;
        case StateEnum.error:
          isSuccess = false;
          break;
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

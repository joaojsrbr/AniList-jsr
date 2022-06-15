// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable

import 'package:anisearch2/api/models/api_graphql_media_model.dart';
import 'package:anisearch2/api/models/api_graphql_model.dart';
import 'package:anisearch2/api/models/api_graphql_pageinfo_model.dart';
import 'package:anisearch2/api/models/api_graphql_url.dart';
import 'package:anisearch2/api/models/api_graphql_query.dart';
import 'package:anisearch2/api/models/api_graphql_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

class ApiProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Media> manga = [];
  PageInfo pageInfoA = PageInfo();
  PageInfo pageInfoM = PageInfo();
  List<Media> anime = [];
  List<Media> searchListSu = [];
  Media searchdetails = Media();

  // List<RequestApiModel> item3 = [];
  // UnmodifiableListView<RequestApiModel> get manga => UnmodifiableListView(item);
  // UnmodifiableListView<RequestApiModel> get anime =>
  //     UnmodifiableListView(item2);

  // Apitest() {
  //   test();
  // }

  ApiProvider() {
    getHomeManga();
    getHomeAnime();
  }

  Future searchDataSu({
    int perPage = 25,
    int page = 0,
    required String query,
  }) async {
    List<Media> tempData = [];
    isLoading = true;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesS(
        page: page,
        perPage: perPage,
        search: query,
      ),
    );

    // final GraphQLClient client = GraphQLClient(
    //   cache: GraphQLCache(),
    //   link: apiHttpURL,
    // );

    // final QueryResult result = await client.query(options);

    final QueryResult result = await _client(apiHttpURL).query(options);

    var repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    searchListSu = tempData;

    isLoading = false;

    notifyListeners();
  }

  Future searchbyID({required int id}) async {
    List<Media> tempData = [];
    isLoading = true;
    PageInfo temppageInfo;
    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesByID(
        id: id,
      ),
    );
    // final GraphQLClient client = GraphQLClient(
    //   cache: GraphQLCache(),
    //   link: apiHttpURL,
    // );
    // final QueryResult result = await client.query(options);

    final QueryResult result = await _client(apiHttpURL).query(options);

    var repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    searchdetails = tempData.first;

    temppageInfo = repositories.page!.pageInfo!;

    isLoading = false;

    notifyListeners();
  }

  Future getMore({
    required List<String> sort,
    required type,
    required bool mangas,
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    isLoading = true;
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
    // final GraphQLClient client = GraphQLClient(
    //   cache: GraphQLCache(),
    //   link: apiHttpURL,
    // );

    // final QueryResult result = await client.query(options);

    final QueryResult result = await _client(apiHttpURL).query(options);
    var repositories = ApiGraphQLModel.fromJson(result.data!);
    tempData = _returnMedia(repositories.page!.media!);
    if (mangas == true) {
      // manga.addAll(tempData);

      for (var i in tempData) {
        var tempMap = manga.map((e) => e.id).toString();
        if (kDebugMode) {
          print(i.id);
        }
        if (tempMap != i.id.toString()) {
          manga.add(i);
        }
      }
      // manga.addAll(tempData);

      // manga.addAll(main);
      temppageInfo = repositories.page!.pageInfo!;
      isLoading = false;
      notifyListeners();
    } else {
      for (var i in tempData) {
        var tempMap = anime.map((e) => e.id).toString();
        if (kDebugMode) {
          print(i.id);
        }
        if (tempMap != i.id.toString()) {
          anime.add(i);
        }
      }
      // anime.addAll(tempData);
      temppageInfo = repositories.page!.pageInfo!;
      isLoading = false;
      notifyListeners();
    }
  }

  Future getHomeAnime({
    List<String> sort = const ["TRENDING_DESC"],
    type = 'ANIME',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    PageInfo temppageInfo;
    isLoading = true;

    final QueryOptions options = QueryOptions(
      document: gql(queryRes),
      variables: variablesG(
        sort: sort,
        type: type,
        page: page,
        perPage: perPage,
      ),
    );

    // final GraphQLClient client = GraphQLClient(
    //   cache: GraphQLCache(),
    //   link: apiHttpURL,
    // );

    // final QueryResult result = await client.query(options);

    final QueryResult result = await _client(apiHttpURL).query(options);

    var repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    temppageInfo = repositories.page!.pageInfo!;

    pageInfoA = temppageInfo;

    anime = tempData;

    isLoading = false;

    notifyListeners();
  }

  Future getHomeManga({
    List<String> sort = const ["TRENDING_DESC"],
    type = 'MANGA',
    int perPage = 25,
    int page = 0,
  }) async {
    List<Media> tempData = [];
    isLoading = true;
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

    // final GraphQLClient client = GraphQLClient(
    //   cache: GraphQLCache(),
    //   link: apiHttpURL,
    // );

    // final QueryResult result = await client.query(options);

    final QueryResult result = await _client(apiHttpURL).query(options);

    var repositories = ApiGraphQLModel.fromJson(result.data!);

    tempData = _returnMedia(repositories.page!.media!);

    manga = tempData;

    temppageInfo = repositories.page!.pageInfo!;

    pageInfoM = temppageInfo;

    isLoading = false;

    notifyListeners();
  }
}

List<Media> _returnMedia(List<Media>? media) {
  return media!
      .map(
        (e) => Media(
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

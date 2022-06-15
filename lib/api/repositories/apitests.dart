// import 'dart:io';

// import 'package:anisearch2/api/models/api_graphql_media_model.dart';
// import 'package:anisearch2/api/models/api_graphql_model.dart';
// import 'package:anisearch2/api/models/api_graphql_url.dart';
// import 'package:anisearch2/api/models/api_graphql_query.dart';
// import 'package:anisearch2/api/models/api_graphql_variables.dart';
// import 'package:graphql/client.dart';

// void main(List<String> args) {
//   test();
// }

// class Query {
//   variables() {
//     const main = <String, dynamic>{
//       // "idMal": 147171,
//       "page": 0,
//       "perPage": 10,
//       "type": "MANGA",
//       "countryOfOrigin": "KR",
//       "sort": ["SCORE_DESC"]
//     };
//     return main;
//   }
// }

// Future test() async {
//   final QueryOptions options = QueryOptions(
//     document: gql(queryRes),
//     variables: variablesG(sort: ["TRENDING_DESC"], type: "MANGA"),
//   );

//   final GraphQLClient client = GraphQLClient(
//     cache: GraphQLCache(),
//     link: apiHttpURL,
//   );

//   final QueryResult result = await client.query(options);
//   var repositories = ApiGraphQLModel.fromJson(result.data!);
//   var media = repositories.page?.media
//       ?.map((e) => Media(
//             sTypename: e.sTypename,
//             description: e.description,
//             bannerImage: e.bannerImage,
//             idMal: e.idMal,
//             averageScore: e.averageScore,
//             countryOfOrigin: e.countryOfOrigin,
//             title: e.title,
//           ))
//       .toList();
//   repositories.page?.media?.forEach((e) => print(e.id));
//   // print(repositories.page?.media?.length);

//   // print(repositories);
//   // print(repositories.page?.media?.first.title?.english);
//   // print(repositories.page?.media?.first.title?.native);
//   // print(repositories.page?.media?.first.title?.romaji);
// }

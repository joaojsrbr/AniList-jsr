import 'package:anisearch2/api/models/api_graphql_page_model.dart';

class ApiGraphQLModel {
  String? sTypename;
  Page? page;

  ApiGraphQLModel({this.sTypename, this.page});

  ApiGraphQLModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    page = json['Page'] != null ? Page.fromJson(json['Page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__typename'] = sTypename;
    if (page != null) {
      data['Page'] = page!.toJson();
    }
    return data;
  }
}

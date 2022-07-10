// ignore_for_file: depend_on_referenced_packages

import 'package:html/parser.dart' show parse;

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

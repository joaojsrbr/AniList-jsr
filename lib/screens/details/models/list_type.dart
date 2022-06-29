// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:ani_search/api/models/api_graphql_media_model.dart';

const List<String> tablistString = [
  'Overview',
  'Characters',
  'Staff',
  'Stats',
  'Social',
];

const List<double> withOpacity = [
  0.8,
  0.7,
  0.6,
  0.5,
  0.4,
  0.3,
  0.2,
  0.1,
  0.05,
  0.005,
  0.0005,
];

String? _formatDate(String data, bool br) {
  if (data == 'null/null/null') {
    return '';
  }
  if (br == true) {
    var inputFormat = DateFormat('d/M/yyyy');
    var inputDate = inputFormat.parse(data); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  } else {
    var inputFormat = DateFormat('d/M/yyyy');
    var inputDate = inputFormat.parse(data); // <-- dd/MM 24H format

    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}

String? nullsafeString(String? data, bool percent) {
  if (data == null) {
    return '';
  } else if (percent == true) {
    return '$data%';
  } else {
    return data;
  }
}

Map<int, Map<String, dynamic>> cardlistString(Media media, String? locales) {
  if (locales == 'BR') {
    return {
      1: {
        'Formato': 'Formato',
        'media': media.format ?? '',
      },
      2: {
        'Status': 'Status',
        'media': media.status ?? '',
      },
      3: {
        'Data de início': 'Data de início',
        'media': _formatDate(
                '${media.startDate?.day}/${media.startDate?.month}/${media.startDate?.year}',
                true) ??
            '',
      },
      4: {
        'Average Score': 'Average Score',
        'media': nullsafeString(media.averageScore?.toString(), true),
      },
      5: {
        'Mean Score': 'Mean Score',
        'media': nullsafeString(media.meanScore?.toString(), true),
      },
      6: {
        'Popularidade': 'Popularidade',
        'media': media.popularity ?? '',
      },
      7: {
        'Favoritos': 'Favoritos',
        'media': media.favourites ?? '',
      },
      8: {
        'Fonte': 'Fonte',
        'media': media.source ?? '',
      },
      9: {
        'Gêneros': 'Gêneros',
        'media': media.genres
                ?.map((e) => e)
                .toString()
                .replaceAll('(', '')
                .replaceAll(')', '') ??
            '',
      },
      10: {
        'Romaji': 'Romaji',
        'media': media.title!.romaji ?? '',
      },
      11: {
        'English': 'English',
        'media': media.title!.english ?? '',
      },
      12: {
        'Nativo': 'Nativo',
        'media': media.title!.native ?? '',
      },
      13: {
        'Episódios': 'Episódios',
        'media': media.episodes ?? '',
      },
    };
  }
  return {
    1: {
      'Format': 'Format',
      'media': media.format ?? '',
    },
    2: {
      'Status': 'Status',
      'media': media.status ?? '',
    },
    3: {
      'Start Date': 'Start Date',
      'media': _formatDate(
              '${media.startDate!.day}/${media.startDate!.month}/${media.startDate!.year}',
              false) ??
          '',
    },
    4: {
      'Average Score': 'Average Score',
      'media': nullsafeString(media.averageScore?.toString(), true),
    },
    5: {
      'Mean Score': 'Mean Score',
      'media': nullsafeString(media.meanScore?.toString(), true),
    },
    6: {
      'Popularity': 'Popularity',
      'media': media.popularity ?? '',
    },
    7: {
      'Favorites': 'Favorites',
      'media': media.favourites ?? '',
    },
    8: {
      'Source': 'Source',
      'media': media.source ?? '',
    },
    9: {
      'Genres': 'Genres',
      'media': media.genres
              ?.map((e) => e)
              .toString()
              .replaceAll('(', '')
              .replaceAll(')', '') ??
          '',
    },
    10: {
      'Romaji': 'Romaji',
      'media': media.title!.romaji ?? '',
    },
    11: {
      'English': 'English',
      'media': media.title!.english ?? '',
    },
    12: {
      'Native': 'Native',
      'media': media.title!.native ?? '',
    },
    13: {
      'Episodes': 'Episodes',
      'media': media.episodes ?? '',
    },
  };
}

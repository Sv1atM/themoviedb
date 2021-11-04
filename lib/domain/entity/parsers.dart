import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/tv.dart';

DateTime? parseDateTimeFromString(String? rawDate) =>
    DateTime.tryParse(rawDate.toString());

MediaType parseMediaTypeFromJson(dynamic json) {
  final jsonMap = json as Map<String, dynamic>;
  final typeIsValid = MediaType.values
      .any((e) => e.asString() == jsonMap['media_type']);
  if (!typeIsValid) throw TypeError();
  return MediaType.values
      .firstWhere((e) => e.asString() == jsonMap['media_type']);
}

ContentType parseContentFromJson(dynamic json) {
  final jsonMap = json as Map<String, dynamic>;
  switch (parseMediaTypeFromJson(jsonMap)) {
    case MediaType.movie:
      return Movie.fromJson(jsonMap);
    case MediaType.tv:
      return TV.fromJson(jsonMap);
    default:
      throw TypeError();
  }
}

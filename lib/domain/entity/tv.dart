import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/parsers.dart';
import 'package:themoviedb/domain/entity/person.dart';

part 'tv.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TV implements ContentType {
  @override
  final int id;
  @override
  final String name;
  @override @JsonKey(name: 'first_air_date', fromJson: parseDateTimeFromString)
  final DateTime? firstReleaseDate;
  @override
  final String? overview;
  @override
  final String? backdropPath;
  @override
  final String? posterPath;
  @override
  final double voteAverage;

  @override
  MediaType get mediaType => MediaType.tv;

  TV({
    required this.id,
    required this.name,
    required this.firstReleaseDate,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
  });

  factory TV.fromJson(Map<String, dynamic> json) => _$TVFromJson(json);

  Map<String, dynamic> toJson() => _$TVToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TVDetails extends TV implements ContentDetails {
  @override
  final List<ContentGenre> genres;
  @override
  final String? tagline;
  @override
  final String status;
  @override
  final ContentCredits credits;
  @override
  final ContentVideos videos;
  @override
  final ContentAccountStates accountStates;
  @JsonKey(name: 'content_ratings')
  final TVCertifications certifications;
  final List<Person> createdBy;
  final List<int> episodeRunTime;

  @override
  int? get runtime => episodeRunTime.isEmpty ? null : episodeRunTime.first;

  TVDetails({
    required int id,
    required String name,
    required DateTime? firstReleaseDate,
    required String? overview,
    required String? backdropPath,
    required String? posterPath,
    required double voteAverage,
    required this.genres,
    required this.tagline,
    required this.status,
    required this.credits,
    required this.videos,
    required this.accountStates,
    required this.certifications,
    required this.createdBy,
    required this.episodeRunTime,
  }) : super(
    id: id,
    name: name,
    firstReleaseDate: firstReleaseDate,
    overview: overview,
    backdropPath: backdropPath,
    posterPath: posterPath,
    voteAverage: voteAverage,
  );

  factory TVDetails.fromJson(Map<String, dynamic> json) => _$TVDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TVDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TVCertifications {
  @JsonKey(name: 'results')
  final List<Rating> list;

  TVCertifications(this.list);

  factory TVCertifications.fromJson(Map<String, dynamic> json) => _$TVCertificationsFromJson(json);

  Map<String, dynamic> toJson() => _$TVCertificationsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Rating {
  @JsonKey(name: 'iso_3166_1')
  final String countryCode;
  @JsonKey(name: 'rating')
  final String rating;

  Rating({
    required this.countryCode,
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

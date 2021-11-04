import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/parsers.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie implements ContentType {
  @override
  final int id;
  @override @JsonKey(name: 'title')
  final String name;
  @override @JsonKey(name: 'release_date', fromJson: parseDateTimeFromString)
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
  MediaType get mediaType => MediaType.movie;

  Movie({
    required this.id,
    required this.name,
    required this.firstReleaseDate,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails extends Movie implements ContentDetails {
  @override
  final List<ContentGenre> genres;
  @override
  final int? runtime;
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
  final MovieReleases releaseDates;

  MovieDetails({
    required int id,
    required String name,
    required DateTime? firstReleaseDate,
    required String? overview,
    required String? backdropPath,
    required String? posterPath,
    required double voteAverage,
    required this.genres,
    required this.runtime,
    required this.tagline,
    required this.status,
    required this.credits,
    required this.videos,
    required this.accountStates,
    required this.releaseDates,
  }) : super(
    id: id,
    name: name,
    firstReleaseDate: firstReleaseDate,
    overview: overview,
    backdropPath: backdropPath,
    posterPath: posterPath,
    voteAverage: voteAverage,
  );

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieReleases {
  @JsonKey(name: 'results')
  final List<MovieRelease> list;

  MovieReleases(this.list);

  factory MovieReleases.fromJson(Map<String, dynamic> json) => _$MovieReleasesFromJson(json);

  Map<String, dynamic> toJson() => _$MovieReleasesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieRelease {
  @JsonKey(name: 'iso_3166_1')
  final String countryCode;
  @JsonKey(name: 'release_dates')
  final List<ReleaseInfo> releases;

  MovieRelease({
    required this.countryCode,
    required this.releases,
  });

  factory MovieRelease.fromJson(Map<String, dynamic> json) => _$MovieReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieReleaseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseInfo {
  final String certification;
  @JsonKey(fromJson: parseDateTimeFromString)
  final DateTime? releaseDate;

  ReleaseInfo({
    required this.certification,
    required this.releaseDate,
  });

  factory ReleaseInfo.fromJson(Map<String, dynamic> json) => _$ReleaseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseInfoToJson(this);
}

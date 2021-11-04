import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/parsers.dart';
import 'package:themoviedb/domain/entity/person.dart';
import 'package:themoviedb/domain/entity/tv.dart';

part 'content_type.g.dart';

enum AccountState { isFavorite, inWatchlist }

extension AccountStateAsString on AccountState {
  String asString() {
    switch (this) {
      case AccountState.isFavorite:
        return 'favorite';
      case AccountState.inWatchlist:
        return 'watchlist';
    }
  }
}

abstract class ContentType extends MediaTypeBase {
  final DateTime? firstReleaseDate;
  final String? overview;
  final String? backdropPath;
  final String? posterPath;
  final double voteAverage;

  ContentType({
    required int id,
    required String name,
    required this.firstReleaseDate,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
  }) : super(
    id: id,
    name: name,
  );
}

abstract class ContentDetails extends ContentType {
  final List<ContentGenre> genres;
  final int? runtime;
  final String? tagline;
  final String status;
  final ContentCredits credits;
  final ContentVideos videos;
  final ContentAccountStates accountStates;

  ContentDetails({
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
  }) : super(
    id: id,
    name: name,
    firstReleaseDate: firstReleaseDate,
    overview: overview,
    backdropPath: backdropPath,
    posterPath: posterPath,
    voteAverage: voteAverage,
  );
}

class CreditsInfo extends ContentType {
  @override
  final MediaType mediaType;

  CreditsInfo({
    required this.mediaType,
    required int id,
    required String name,
    required DateTime? firstReleaseDate,
    required String? overview,
    required String? backdropPath,
    required String? posterPath,
    required double voteAverage,
  }) : super(
    id: id,
    name: name,
    firstReleaseDate: firstReleaseDate,
    overview: overview,
    backdropPath: backdropPath,
    posterPath: posterPath,
    voteAverage: voteAverage,
  );

  factory CreditsInfo.fromJson(Map<String, dynamic> json) {
    final content = parseContentFromJson(json);
    return CreditsInfo(
      mediaType: content.mediaType,
      id: content.id,
      name: content.name,
      firstReleaseDate: content.firstReleaseDate,
      overview: content.overview,
      backdropPath: content.backdropPath,
      posterPath: content.posterPath,
      voteAverage: content.voteAverage,
    );
  }

  Map<String, dynamic> toJson() {
    switch (mediaType) {
      case MediaType.movie:
        return Movie(
          id: id,
          name: name,
          firstReleaseDate: firstReleaseDate,
          overview: overview,
          backdropPath: backdropPath,
          posterPath: posterPath,
          voteAverage: voteAverage,
        ).toJson();

      case MediaType.tv:
        return TV(
          id: id,
          name: name,
          firstReleaseDate: firstReleaseDate,
          overview: overview,
          backdropPath: backdropPath,
          posterPath: posterPath,
          voteAverage: voteAverage,
        ).toJson();

      default:
        return <String, dynamic>{};
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ContentGenre {
  final String name;

  ContentGenre(this.name);

  factory ContentGenre.fromJson(Map<String, dynamic> json) => _$ContentGenreFromJson(json);

  Map<String, dynamic> toJson() => _$ContentGenreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContentCredits {
  final List<Actor> cast;
  final List<CrewMember> crew;

  ContentCredits({
    required this.cast,
    required this.crew,
  });

  factory ContentCredits.fromJson(Map<String, dynamic> json) => _$ContentCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentCreditsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContentVideos {
  @JsonKey(name: 'results')
  final List<Video> list;

  ContentVideos(this.list);

  factory ContentVideos.fromJson(Map<String, dynamic> json) => _$ContentVideosFromJson(json);

  Map<String, dynamic> toJson() => _$ContentVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Video {
  final String key;
  final String site;
  final String type;
  final bool official;

  Video({
    required this.key,
    required this.site,
    required this.type,
    required this.official,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class ContentAccountStates {
  @JsonKey(name: 'favorite')
  bool isFavorite;
  @JsonKey(name: 'watchlist')
  bool inWatchlist;

  ContentAccountStates({
    required this.isFavorite,
    required this.inWatchlist,
  });

  factory ContentAccountStates.fromJson(Map<String, dynamic> json) => _$ContentAccountStatesFromJson(json);

  Map<String, dynamic> toJson() => _$ContentAccountStatesToJson(this);
}

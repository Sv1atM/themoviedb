// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      name: json['title'] as String,
      firstReleaseDate:
          parseDateTimeFromString(json['release_date'] as String?),
      overview: json['overview'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
      'release_date': instance.firstReleaseDate?.toIso8601String(),
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
    };

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) => MovieDetails(
      id: json['id'] as int,
      name: json['title'] as String,
      firstReleaseDate:
          parseDateTimeFromString(json['release_date'] as String?),
      overview: json['overview'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => ContentGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      runtime: json['runtime'] as int?,
      tagline: json['tagline'] as String?,
      status: json['status'] as String,
      credits: ContentCredits.fromJson(json['credits'] as Map<String, dynamic>),
      videos: ContentVideos.fromJson(json['videos'] as Map<String, dynamic>),
      accountStates: ContentAccountStates.fromJson(
          json['account_states'] as Map<String, dynamic>),
      releaseDates:
          MovieReleases.fromJson(json['release_dates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
      'release_date': instance.firstReleaseDate?.toIso8601String(),
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'genres': instance.genres.map((e) => e.toJson()).toList(),
      'runtime': instance.runtime,
      'tagline': instance.tagline,
      'status': instance.status,
      'credits': instance.credits.toJson(),
      'videos': instance.videos.toJson(),
      'account_states': instance.accountStates.toJson(),
      'release_dates': instance.releaseDates.toJson(),
    };

MovieReleases _$MovieReleasesFromJson(Map<String, dynamic> json) =>
    MovieReleases(
      (json['results'] as List<dynamic>)
          .map((e) => MovieRelease.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieReleasesToJson(MovieReleases instance) =>
    <String, dynamic>{
      'results': instance.list.map((e) => e.toJson()).toList(),
    };

MovieRelease _$MovieReleaseFromJson(Map<String, dynamic> json) => MovieRelease(
      countryCode: json['iso_3166_1'] as String,
      releases: (json['release_dates'] as List<dynamic>)
          .map((e) => ReleaseInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieReleaseToJson(MovieRelease instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.countryCode,
      'release_dates': instance.releases.map((e) => e.toJson()).toList(),
    };

ReleaseInfo _$ReleaseInfoFromJson(Map<String, dynamic> json) => ReleaseInfo(
      certification: json['certification'] as String,
      releaseDate: parseDateTimeFromString(json['release_date'] as String?),
    );

Map<String, dynamic> _$ReleaseInfoToJson(ReleaseInfo instance) =>
    <String, dynamic>{
      'certification': instance.certification,
      'release_date': instance.releaseDate?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TV _$TVFromJson(Map<String, dynamic> json) => TV(
      id: json['id'] as int,
      name: json['name'] as String,
      firstReleaseDate:
          parseDateTimeFromString(json['first_air_date'] as String?),
      overview: json['overview'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$TVToJson(TV instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'first_air_date': instance.firstReleaseDate?.toIso8601String(),
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
    };

TVDetails _$TVDetailsFromJson(Map<String, dynamic> json) => TVDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      firstReleaseDate:
          parseDateTimeFromString(json['first_air_date'] as String?),
      overview: json['overview'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => ContentGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagline: json['tagline'] as String?,
      status: json['status'] as String,
      credits: ContentCredits.fromJson(json['credits'] as Map<String, dynamic>),
      videos: ContentVideos.fromJson(json['videos'] as Map<String, dynamic>),
      accountStates: ContentAccountStates.fromJson(
          json['account_states'] as Map<String, dynamic>),
      certifications: TVCertifications.fromJson(
          json['content_ratings'] as Map<String, dynamic>),
      createdBy: (json['created_by'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$TVDetailsToJson(TVDetails instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'first_air_date': instance.firstReleaseDate?.toIso8601String(),
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'genres': instance.genres.map((e) => e.toJson()).toList(),
      'tagline': instance.tagline,
      'status': instance.status,
      'credits': instance.credits.toJson(),
      'videos': instance.videos.toJson(),
      'account_states': instance.accountStates.toJson(),
      'content_ratings': instance.certifications.toJson(),
      'created_by': instance.createdBy.map((e) => e.toJson()).toList(),
      'episode_run_time': instance.episodeRunTime,
    };

TVCertifications _$TVCertificationsFromJson(Map<String, dynamic> json) =>
    TVCertifications(
      (json['results'] as List<dynamic>)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TVCertificationsToJson(TVCertifications instance) =>
    <String, dynamic>{
      'results': instance.list.map((e) => e.toJson()).toList(),
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      countryCode: json['iso_3166_1'] as String,
      rating: json['rating'] as String,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'iso_3166_1': instance.countryCode,
      'rating': instance.rating,
    };

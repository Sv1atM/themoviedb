// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentGenre _$ContentGenreFromJson(Map<String, dynamic> json) => ContentGenre(
      json['name'] as String,
    );

Map<String, dynamic> _$ContentGenreToJson(ContentGenre instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ContentCredits _$ContentCreditsFromJson(Map<String, dynamic> json) =>
    ContentCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => CrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentCreditsToJson(ContentCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

ContentVideos _$ContentVideosFromJson(Map<String, dynamic> json) =>
    ContentVideos(
      (json['results'] as List<dynamic>)
          .map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentVideosToJson(ContentVideos instance) =>
    <String, dynamic>{
      'results': instance.list.map((e) => e.toJson()).toList(),
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      key: json['key'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
      official: json['official'] as bool,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'key': instance.key,
      'site': instance.site,
      'type': instance.type,
      'official': instance.official,
    };

ContentAccountStates _$ContentAccountStatesFromJson(
        Map<String, dynamic> json) =>
    ContentAccountStates(
      isFavorite: json['favorite'] as bool,
      inWatchlist: json['watchlist'] as bool,
    );

Map<String, dynamic> _$ContentAccountStatesToJson(
        ContentAccountStates instance) =>
    <String, dynamic>{
      'favorite': instance.isFavorite,
      'watchlist': instance.inWatchlist,
    };

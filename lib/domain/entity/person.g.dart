// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      knownFor: Person.parseKnownForString(json['known_for']),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for': instance.knownFor,
    };

PersonDetails _$PersonDetailsFromJson(Map<String, dynamic> json) =>
    PersonDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String,
      gender: PersonDetails.parseGender(json['gender'] as int),
      placeOfBirth: json['place_of_birth'] as String?,
      birthday: parseDateTimeFromString(json['birthday'] as String?),
      deathday: parseDateTimeFromString(json['deathday'] as String?),
      biography: json['biography'] as String,
      homepage: json['homepage'] as String?,
      credits: PersonCredits.fromJson(
          json['combined_credits'] as Map<String, dynamic>),
      socialIDs: PersonExternalIDs.fromJson(
          json['external_ids'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonDetailsToJson(PersonDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownForDepartment,
      'gender': instance.gender,
      'place_of_birth': instance.placeOfBirth,
      'birthday': instance.birthday?.toIso8601String(),
      'deathday': instance.deathday?.toIso8601String(),
      'biography': instance.biography,
      'homepage': instance.homepage,
      'combined_credits': instance.credits.toJson(),
      'external_ids': instance.socialIDs.toJson(),
    };

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String,
      character: json['character'] as String,
    );

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownForDepartment,
      'character': instance.character,
    };

CrewMember _$CrewMemberFromJson(Map<String, dynamic> json) => CrewMember(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String,
      department: json['department'] as String,
      job: json['job'] as String,
    );

Map<String, dynamic> _$CrewMemberToJson(CrewMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownForDepartment,
      'department': instance.department,
      'job': instance.job,
    };

PersonCredits _$PersonCreditsFromJson(Map<String, dynamic> json) =>
    PersonCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CreditsInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => CreditsInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonCreditsToJson(PersonCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

PersonExternalIDs _$PersonExternalIDsFromJson(Map<String, dynamic> json) =>
    PersonExternalIDs(
      facebook: json['facebook_id'] as String?,
      twitter: json['twitter_id'] as String?,
      instagram: json['instagram_id'] as String?,
    );

Map<String, dynamic> _$PersonExternalIDsToJson(PersonExternalIDs instance) =>
    <String, dynamic>{
      'facebook_id': instance.facebook,
      'twitter_id': instance.twitter,
      'instagram_id': instance.instagram,
    };

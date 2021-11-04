import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/entity/parsers.dart';

part 'person.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Person extends MediaTypeBase {
  final String? profilePath;
  @JsonKey(fromJson: parseKnownForString)
  final String knownFor;

  @override
  MediaType get mediaType => MediaType.person;

  Person({
    required int id,
    required String name,
    required this.profilePath,
    required this.knownFor,
  }) : super(
    id: id,
    name: name,
  );

  static String parseKnownForString(dynamic json) {
    return (json is List)
        ? json.map((dynamic json) => parseContentFromJson(json).name).join(', ')
        : json.toString();
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PersonDetails extends Person {
  final String knownForDepartment;
  @JsonKey(fromJson: parseGender)
  final String gender;
  final String? placeOfBirth;
  @JsonKey(fromJson: parseDateTimeFromString)
  final DateTime? birthday;
  @JsonKey(fromJson: parseDateTimeFromString)
  final DateTime? deathday;
  final String biography;
  final String? homepage;
  @JsonKey(name: 'combined_credits')
  final PersonCredits credits;
  @JsonKey(name: 'external_ids')
  final PersonExternalIDs socialIDs;

  PersonDetails({
    required int id,
    required String name,
    required String? profilePath,
    required this.knownForDepartment,
    required this.gender,
    required this.placeOfBirth,
    required this.birthday,
    required this.deathday,
    required this.biography,
    required this.homepage,
    required this.credits,
    required this.socialIDs,
  }) : super(
    id: id,
    name: name,
    profilePath: profilePath,
    knownFor: knownForDepartment,
  );

  static String parseGender(int genderId) {
    switch (genderId) {
      case 1:
        return 'Female';
      case 2:
        return 'Male';
      default:
        return 'Not specified';
    }
  }

  factory PersonDetails.fromJson(Map<String, dynamic> json) => _$PersonDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Actor extends Person {
  final String knownForDepartment;
  final String character;

  Actor({
    required int id,
    required String name,
    required String? profilePath,
    required this.knownForDepartment,
    required this.character,
  }) : super(
    id: id,
    name: name,
    profilePath: profilePath,
    knownFor: knownForDepartment,
  );

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CrewMember extends Person {
  final String knownForDepartment;
  final String department;
  final String job;

  CrewMember({
    required int id,
    required String name,
    required String? profilePath,
    required this.knownForDepartment,
    required this.department,
    required this.job,
  }) : super(
    id: id,
    name: name,
    profilePath: profilePath,
    knownFor: knownForDepartment,
  );

  factory CrewMember.fromJson(Map<String, dynamic> json) => _$CrewMemberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CrewMemberToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PersonCredits {
  final List<CreditsInfo> cast;
  final List<CreditsInfo> crew;

  PersonCredits({
    required this.cast,
    required this.crew,
  });

  factory PersonCredits.fromJson(Map<String, dynamic> json) => _$PersonCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonCreditsToJson(this);
}

@JsonSerializable()
class PersonExternalIDs {
  @JsonKey(name: 'facebook_id')
  final String? facebook;
  @JsonKey(name: 'twitter_id')
  final String? twitter;
  @JsonKey(name: 'instagram_id')
  final String? instagram;

  PersonExternalIDs({
    this.facebook,
    this.twitter,
    this.instagram,
  });

  factory PersonExternalIDs.fromJson(Map<String, dynamic> json) => _$PersonExternalIDsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonExternalIDsToJson(this);
}

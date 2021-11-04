import 'package:json_annotation/json_annotation.dart';

part 'account_info.g.dart';

@JsonSerializable()
class AccountInfo {
  final int id;
  final String username;

  AccountInfo({
    required this.id,
    required this.username,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}

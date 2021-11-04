import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, genericArgumentFactories: true)
class Response<T> {
  final List<T> results;
  final int page;
  final int totalPages;

  Response({
    required this.results,
    required this.page,
    required this.totalPages,
  });

  factory Response.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ResponseToJson(this, toJsonT);
}

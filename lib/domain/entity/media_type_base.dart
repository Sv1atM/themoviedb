enum MediaType { movie, tv, person }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
      case MediaType.person:
        return 'person';
    }
  }
}

abstract class MediaTypeBase {
  final int id;
  final String name;

  MediaType get mediaType;

  MediaTypeBase({
    required this.id,
    required this.name,
  });
}

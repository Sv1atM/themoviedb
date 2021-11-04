import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/domain/services/media_service.dart';
import 'package:themoviedb/library/response.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class MediaSearchModel<T extends MediaTypeBase> extends MediaListModel<T> {
  MediaSearchModel(BuildContext context) : super(context);

  final _mediaService = MediaService();
  String _searchQuery = '';
  Timer? _searchDebounce;

  Future<void> searchContent(String text) async {
    final query = text.trim();
    if (query != _searchQuery) {
      _searchDebounce?.cancel();
      _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
        _searchQuery = query;
        await resetList();
      });
    }
  }

  @override
  Future<Response<T>?> loadContent(int page) async {
    if (_searchQuery.isEmpty) return null;
    return _mediaService.search(
      mediaType,
      query: _searchQuery,
      page: page,
      locale: locale,
    );
  }
}

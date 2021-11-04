import 'package:themoviedb/library/response.dart';

typedef PaginatorLoader<T> = Future<Response<T>?> Function(int page);

class Paginator<T> {
  Paginator(this._loader);

  final PaginatorLoader<T> _loader;
  int _currentPage = 0;
  int _totalPages = 1;
  bool _isLoadingInProgress = false;

  final _data = <T>[];
  List<T> get data => _data;

  Future<void> loadNextPage() async {
    if (_isLoadingInProgress || _currentPage == _totalPages) return;
    _isLoadingInProgress = true;
    try {
      final response = await _loader(_currentPage + 1);
      if (response != null) {
        _data.addAll(response.results);
        _currentPage = response.page;
        _totalPages = response.totalPages;
      }
    } finally {
      _isLoadingInProgress = false;
    }
  }

  Future<void> resetList() async {
    _data.clear();
    _currentPage = 0;
    _totalPages = 1;
    await loadNextPage();
  }
}

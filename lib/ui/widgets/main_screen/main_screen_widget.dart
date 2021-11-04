import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/media_search/media_search_delegate.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/media_search/media_search_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  final _screenFactory = ScreenFactory();
  int _selectedTab = 0;

  void _onTabSelect(int index) {
    if (_selectedTab != index) setState(() => _selectedTab = index);
  }

  void _openSearch() => showSearch(
    context: context,
    delegate: MediaSearchDelegate(),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MediaSearchModel?>()?.setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDb'),
        actions: [
          const _PopupMenuWidget(),
          IconButton(
            onPressed: _openSearch,
            icon: const Icon(Icons.search, color: AppColors.mainLightBlue),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.movieList(),
          _screenFactory.tvList(),
          _screenFactory.peopleList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV Shows'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
        ],
        onTap: _onTabSelect,
      ),
    );
  }
}

class _PopupMenuWidget extends StatelessWidget {
  const _PopupMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();

    return ValueListenableBuilder<String?>(
      valueListenable: model.username,
      builder: (context, username, _) => PopupMenuButton<int>(
        onSelected: model.onSelectedMenuItem,
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(username ?? 'unknown',
              style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
            ),
          ),
          const PopupMenuDivider(),
          _menuItem(1, 'Favorites'),
          _menuItem(2, 'Watchlist'),
          const PopupMenuDivider(),
          _menuItem(3, 'Logout'),
        ],
        child: CircleAvatar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          radius: 16,
          child: (username != null)
              ? Text(username[0].toUpperCase())
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  PopupMenuItem<T> _menuItem<T>(T value, String text) => PopupMenuItem(
    value: value,
    height: 0,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    child: Text(text, style: AppTextStyles.em(1, color: Colors.black45)),
  );
}

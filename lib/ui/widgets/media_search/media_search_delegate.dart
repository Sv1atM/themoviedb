import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/ui/widgets/media_search/media_search_model.dart';

class MediaSearchDelegate<T extends MediaTypeBase> extends SearchDelegate<T> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      onPressed: () => query = '',
      icon: const Icon(Icons.close),
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: Navigator.of(context).pop,
    icon: const Icon(Icons.arrow_back),
  );

  @override
  Widget buildResults(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSuggestions(BuildContext context) => ChangeNotifierProvider(
    create: (context) => MediaSearchModel<T>(context),
    child: Consumer<MediaSearchModel<T>>(
      builder: (context, model, _) {
        final searchResults = model.mediaList;
        model.searchContent(query);

        return ListView.separated(
          itemBuilder: (context, index)  {
            if (index == searchResults.length - 1) model.loadNextPage();
            return _suggestionListItemWidget(context, searchResults[index]);
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: searchResults.length,
        );
      },
    ),
  );

  Widget _suggestionListItemWidget(BuildContext context, T item) => InkWell(
    onTap: () => print(item.name),
    child: SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 10),
            Expanded(
              child: Text(item.name,
                style: const TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

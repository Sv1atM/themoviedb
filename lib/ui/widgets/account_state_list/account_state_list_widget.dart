import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/domain/entity/media_type_base.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/account_state_list/account_state_list_combiner.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';

class AccountStateListWidget extends StatefulWidget {
  const AccountStateListWidget({Key? key}) : super(key: key);

  @override
  State<AccountStateListWidget> createState() => _AccountStateListWidgetState();
}

class _AccountStateListWidgetState extends State<AccountStateListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<AccountStateListCombiner>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        actions: const [
          _ContentTypeToggleWidget(),
        ],
      ),
      body: const _ListWidget(),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountState = context.read<AccountStateListCombiner>().state;
    final title = _getTitle(accountState);
    return Text(title);
  }

  String _getTitle(AccountState accountState) {
    switch (accountState) {
      case AccountState.isFavorite:
        return 'My Favorites';
      case AccountState.inWatchlist:
        return 'My Watchlist';
    }
  }
}

class _ContentTypeToggleWidget extends StatelessWidget {
  const _ContentTypeToggleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountStateListCombiner>();

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<MediaType>(
            value: model.mediaType,
            style: const TextStyle(color: Colors.white),
            dropdownColor: AppColors.mainLightBlue.withOpacity(0.95),
            onChanged: (mediaType) => model.resetMediaType(mediaType!),
            items: const [
              DropdownMenuItem(value: MediaType.movie, child: Text('Movies')),
              DropdownMenuItem(value: MediaType.tv, child: Text('TV')),
            ],
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.mainLightBlue),
          ),
        ),
      ),
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountStateListCombiner>();
    final content = model.mediaList;

    return ListView.builder(
      key: content.isNotEmpty ? ObjectKey(content.first) : null,
      padding: const EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: content.length,
      itemBuilder: (context, index) {
        if (index == content.length - 1) model.loadNextPage();
        return _ListItemWidget(index: index);
      },
    );
  }
}

class _ListItemWidget extends StatelessWidget {
  const _ListItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountStateListCombiner>();
    final content = model.mediaList[index];
    final releaseDate = model.formattedDateString(content.firstReleaseDate);

    return Dismissible(
      key: ValueKey(content.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => model.removeItemAt(index),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 141,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.15)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.67,
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(5.5)),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: (content.posterPath?.isNotEmpty ?? false)
                              ? Image.network(ImageDownloader.makeUrl(content.posterPath!))
                              : Image.asset(AppImages.posterPlaceholder),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(content.name,
                              style: AppTextStyles.em(1, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (releaseDate != null) ...[
                              const SizedBox(height: 5),
                              Text(releaseDate,
                                style: AppTextStyles.em(1, color: Colors.grey),
                              ),
                            ],
                            if (content.overview?.isNotEmpty ?? false) ...[
                              const SizedBox(height: 20),
                              Text(content.overview!,
                                style: AppTextStyles.em(0.9),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TappableWidget(onTap: () => model.openDetails(content)),
            ],
          ),
        ),
      ),
    );
  }
}

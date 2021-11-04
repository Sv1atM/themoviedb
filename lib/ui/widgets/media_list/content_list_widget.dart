import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/domain/entity/content_type.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/elements/tappable_widget.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class ContentListWidget<T extends ContentType> extends StatefulWidget {
  const ContentListWidget({Key? key}) : super(key: key);

  @override
  State<ContentListWidget<T>> createState() => _ContentListWidgetState<T>();
}

class _ContentListWidgetState<T extends ContentType> extends State<ContentListWidget<T>> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MediaListModel<T>>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MediaListModel<T>>();
    final content = model.mediaList;

    return ListView.separated(
      key: content.isNotEmpty ? ObjectKey(content.first) : null,
      padding: const EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: content.length,
      itemBuilder: (context, index) {
        if (index == content.length - 1) model.loadNextPage();
        return _ContentListItemWidget<T>(item: content[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}

class _ContentListItemWidget<T extends ContentType> extends StatelessWidget {
  const _ContentListItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final T item;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MediaListModel<T>>();
    final releaseDate = model.formattedDateString(item.firstReleaseDate);
    final posterPath = item.posterPath ?? '';
    final overview = item.overview ?? '';

    return SizedBox(
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
                      child: (posterPath.isNotEmpty)
                          ? Image.network(ImageDownloader.makeUrl(item.posterPath!))
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
                        Text(item.name,
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
                        if (overview.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Text(item.overview!,
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
          TappableWidget(onTap: () => model.openDetails(item)),
        ],
      ),
    );
  }
}

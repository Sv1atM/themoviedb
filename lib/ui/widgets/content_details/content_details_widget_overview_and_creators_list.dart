import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/content_details/content_details_model.dart';

class ContentDetailsOverviewAndCreatorsListWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const ContentDetailsOverviewAndCreatorsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _OverviewWidget<M>(),
          const SizedBox(height: 20),
          _CreatorsListWidget<M>(),
        ],
      ),
    );
  }
}

class _OverviewWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();
    final tagline = model.details!.tagline ?? '';
    final overview = model.details!.overview ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tagline.isNotEmpty) ...[
          Text(tagline,
            style: AppTextStyles.em(1.1,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (overview.isNotEmpty) ...[
          Text('Overview',
            style: AppTextStyles.em(1.3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(overview,
              style: AppTextStyles.em(1, color: Colors.white),
            ),
          ),
        ],
      ],
    );
  }
}

class _CreatorsListWidget<M extends ContentDetailsModel> extends StatelessWidget {
  const _CreatorsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<M>();
    final creators = model.getCreators();
    final currentOrientation = MediaQuery.of(context).orientation;
    final isPortraitOrientation = currentOrientation == Orientation.portrait;
    final columnsCount = isPortraitOrientation ? 2 : 3;

    return Table(
      children: [
        for (var i = 0; i < creators.length; i += columnsCount) TableRow(
          children: List.generate(columnsCount, (index) {
            try {
              final current = creators.entries.elementAt(index + i);
              return TableCell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(current.key,
                      style: AppTextStyles.em(1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: null,
                    ),
                    Text(current.value,
                      style: AppTextStyles.em(0.9, color: Colors.white),
                      maxLines: null,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } on IndexError {
              return const TableCell(child: SizedBox.shrink());
            }
          }),
        ),
      ],
    );
  }
}

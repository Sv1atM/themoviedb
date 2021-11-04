import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/theme/app_text_styles.dart';
import 'package:themoviedb/ui/widgets/text_painter.dart';
import 'package:themoviedb/ui/widgets/person_details/person_details_model.dart';

class PersonDetailsBiographyWidget extends StatefulWidget {
  const PersonDetailsBiographyWidget({Key? key}) : super(key: key);

  @override
  _PersonDetailsBiographyWidgetState createState() => _PersonDetailsBiographyWidgetState();
}

class _PersonDetailsBiographyWidgetState extends State<PersonDetailsBiographyWidget> {
  bool _textExceedMaxLines = true;

  void _showWholeText() => setState(() => _textExceedMaxLines = false);

  @override
  Widget build(BuildContext context) {
    final biography = context.read<PersonDetailsModel>().personDetails!.biography;

    if (biography.isEmpty) return const SizedBox.shrink();

    const contentPadding = 20.0;
    final layoutWidth = MediaQuery.of(context).size.width - 2 * contentPadding;
    final biographyText = Text(biography,
      style: AppTextStyles.em(1),
      maxLines: _textExceedMaxLines ? 10 : null,
    );
    if (_textExceedMaxLines) {
      _textExceedMaxLines = textPainter(
        textWidget: biographyText,
        layoutWidth: layoutWidth,
      ).didExceedMaxLines;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: contentPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text('Biography',
            style: AppTextStyles.em(1.3, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              biographyText,
              if (_textExceedMaxLines)
                Positioned(
                  bottom: 0,
                  height: 20,
                  width: layoutWidth,
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withAlpha(0),
                                Colors.white,
                              ],
                            ),
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                      TextButton(
                        onPressed: _showWholeText,
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(AppColors.mainLightBlue),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.only(left: 30)),
                        ),
                        child: Row(
                          children: const [
                            Text('Read More',
                              style: TextStyle(
                                fontSize: AppTextStyles.mainFontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

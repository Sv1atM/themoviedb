import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';

class UserScoreWidget extends StatelessWidget {
  final double voteAverage;
  final double radius;

  const UserScoreWidget({
    Key? key,
    required this.voteAverage,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color lineColor;
    final String ratingText;
    final String? fontFamily;
    const textColor = Colors.white;
    const textFontWeight = FontWeight.bold;
    final textFontSize = radius * 0.7;

    if (voteAverage == 0) {
      lineColor = Colors.white;
      ratingText = 'NR';
      fontFamily = null;
    } else {
      if (voteAverage >= 7) {
        lineColor = const Color(0xFF21D07A);
      } else if (voteAverage >= 4) {
        lineColor = const Color(0xFFD2D531);
      } else {
        lineColor = const Color(0xFFDB2360);
      }
      ratingText = (voteAverage * 10).truncate().toString();
      fontFamily = 'UniformRounded';
    }

    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ratingText,
          style: TextStyle(
            color: textColor,
            fontFamily: fontFamily,
            fontSize: textFontSize,
            fontWeight: textFontWeight,
          ),
        ),
        if (voteAverage > 0)
          Text('%',
            style: TextStyle(
              color: textColor,
              fontFamily: fontFamily,
              fontSize: textFontSize / 2,
              fontWeight: textFontWeight,
            ),
          ),
      ],
    );

    return RadialPercentWidget(
      percent: voteAverage / 10,
      radius: radius,
      backgroundColor: const Color(0xFF081C22),
      lineColor: lineColor,
      child: child,
    );
  }
}

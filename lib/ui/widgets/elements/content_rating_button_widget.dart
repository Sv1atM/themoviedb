import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/elements/account_state_button_widget.dart';

class ContentRatingButtonWidget extends StatefulWidget {
  const ContentRatingButtonWidget({Key? key}) : super(key: key);

  @override
  State<ContentRatingButtonWidget> createState() => _ContentRatingButtonWidgetState();
}

class _ContentRatingButtonWidgetState extends State<ContentRatingButtonWidget> {
  bool _isPressed = false;

  void _toggle() => setState(() => _isPressed = !_isPressed);

  @override
  Widget build(BuildContext context) {
    return AccountStateButtonWidget(
      onPressed: _toggle,
      icon: Icons.star,
    );
  }
}

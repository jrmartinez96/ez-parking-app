import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    Key? key,
    this.title = '',
    this.color = primaryTextColor,
    this.horizontalPadding = 0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final String title;
  final Color color;
  final double horizontalPadding;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline1!.merge(TextStyle(color: color));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        title,
        textAlign: textAlign,
        style: textStyle,
      ),
    );
  }
}

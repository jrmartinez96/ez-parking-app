import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';

class RoundedCard extends StatelessWidget {
  RoundedCard(
      {Key? key,
      this.onPressed,
      required this.child,
      this.borderRadius = 20,
      this.padding = const EdgeInsets.all(12),
      this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      this.backgroundColor})
      : super(key: key);

  final GestureTapCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: boxShadow,
          ),
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

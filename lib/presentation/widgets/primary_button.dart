import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.onPressed,
      required this.title,
      this.color = primary,
      this.textColor = Colors.white,
      this.constraints = const BoxConstraints(minWidth: 88, minHeight: 36),
      this.verticalPadding,
      this.buttonStyle})
      : super(key: key);

  final void Function()? onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final BoxConstraints constraints;
  final double? verticalPadding;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle ??
          ElevatedButton.styleFrom(
              primary: color,
              padding: const EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Container(
        constraints: constraints,
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

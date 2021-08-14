import 'package:ez_parking_app/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SliverBottomButton extends StatelessWidget {
  const SliverBottomButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          padding: const EdgeInsets.only(bottom: 10),
          child: PrimaryButton(
            title: title,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

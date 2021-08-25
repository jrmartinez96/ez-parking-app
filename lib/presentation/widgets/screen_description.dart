import 'package:flutter/material.dart';

class ScreenDescription extends StatelessWidget {
  const ScreenDescription({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

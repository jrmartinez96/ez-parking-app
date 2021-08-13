import 'package:flutter/material.dart';

class FieldsTransactions extends StatelessWidget {
  const FieldsTransactions({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            Expanded(child: Container()),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LabelActive extends StatelessWidget {
  const LabelActive({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23,
        width: 86,
        decoration: BoxDecoration(
          color: (isActive) ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          (isActive) ? 'Activa' : 'Inactiva',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ));
  }
}

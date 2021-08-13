import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';

class LoadingCircularProgressIndicator extends StatelessWidget {
  const LoadingCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primary,
      ),
    );
  }
}

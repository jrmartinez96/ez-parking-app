import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({Key? key, this.backgroundColor, this.borderRadius = 20, required this.child, this.total})
      : super(key: key);

  final Color? backgroundColor;
  final double borderRadius;
  final Widget child;
  final double? total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          child,
          if (total != null)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'L${total!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            )
          else
            Container()
        ],
      ),
    );
  }
}

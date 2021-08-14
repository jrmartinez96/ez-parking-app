import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/presentation/widgets/cards/rounded_card.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({
    Key? key,
    required this.title,
    required this.description,
    this.imagePath,
    this.imageUrl,
    this.imageBase64,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.arrowColor,
  }) : super(key: key);

  final String title;
  final String description;
  final String? imagePath;
  final String? imageUrl;
  final String? imageBase64;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? arrowColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget imageItem;
    if (imagePath != null) {
      imageItem = Image.asset(
        imagePath!,
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.width * 0.19,
      );
    } else if (imageUrl != null) {
      imageItem = Image.network(
        imageUrl!,
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.width * 0.19,
        errorBuilder: (_, __, ___) {
          return Image.asset(
            'assets/images/promotions.png',
            width: MediaQuery.of(context).size.width * 0.19,
            height: MediaQuery.of(context).size.width * 0.19,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const LoadingCircularProgressIndicator();
        },
      );
    } else if (imageBase64 != null) {
      imageItem = Image.memory(
        base64Decode(imageBase64!),
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.width * 0.19,
      );
    } else {
      imageItem = Image.asset(
        'assets/images/promotions.png',
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.width * 0.19,
      );
    }

    return RoundedCard(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        child: Row(
          children: [
            imageItem,
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: textColor),
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: arrowColor ?? primary,
              ),
            )
          ],
        ));
  }
}

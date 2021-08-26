import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class CreditCardsScreen extends StatefulWidget {
  CreditCardsScreen({Key? key}) : super(key: key);

  @override
  _CreditCardsScreenState createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: const [
            ScreenHeader(
              title: 'Tarjetas de crédito',
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }
}

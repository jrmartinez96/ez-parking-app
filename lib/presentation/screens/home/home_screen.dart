import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(
            Icons.history,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.credit_card, size: 40, color: Colors.white),
            onPressed: () => Navigator.of(context).pushNamed('/credit_cards'),
          ),
        ],
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/company_logo.png',
            height: 45,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {},
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxShadow,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/icons/tap_on_phone_white.svg',
                      semanticsLabel: 'Tap on phone',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

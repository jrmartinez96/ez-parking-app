import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.history,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/transactions');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 35, color: Colors.white),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
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
                onTap: () {
                  utils.showCustomAlert(
                    context,
                    img: 'assets/images/work_in_progress.png',
                    title: '¡Oh uh!',
                    message: 'Esta funcionalidad no se encuentra disponible aún.',
                  );
                },
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

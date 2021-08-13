import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: primary.withOpacity(0.43),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Stack(
        children: [
          _buildWelcome(),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.19,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido',
                style: Theme.of(context).textTheme.headline1!.merge(const TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Fortaleciendo a tu clinte interno, siempre a tu lado.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: PrimaryButton(
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false),
                  title: 'Iniciar sesión',
                  color: Colors.white,
                  textColor: primaryTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

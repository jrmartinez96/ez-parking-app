import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/auth/welcome/welcome_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WelcomeCubit>(),
      child: BlocConsumer<WelcomeCubit, WelcomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: OnBoardingSlider(
              headerBackgroundColor: Colors.white,
              controllerColor: primary,
              buttonText: 'Registrarme',
              skipTextButton: const Text('Saltar'),
              finishButton: const Text('Iniciar sesión'),
              background: [
                Container(),
                Container(),
                Container(),
                Container(),
              ],
              totalPage: 4,
              speed: 1.8,
              bodyHeight: 650,
              bodyWidth: 500,
              pageBodies: _buildOnBoardingSteps(),
              onFinish: (dynamic settings) {
                context.read<WelcomeCubit>().setOnBoarding();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              onPageFinish: (dynamic settings) {
                context.read<WelcomeCubit>().setOnBoarding();
                Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
              },
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildOnBoardingSteps() {
    return [
      _buildPageContent(
        title: 'Bienvenido',
        description: 'Una nueva manera para pagar tu parqueo.',
        imagePath: 'assets/images/company_logo.png',
      ),
      _buildPageContentSvg(
        title: 'Tap on phone',
        description: 'Podras entrar, pagar, y salir de un centro comercial con un solo tap.',
        svgPath: 'assets/icons/tap_on_phone.svg',
      ),
      _buildPageContent(
        title: 'Tarjetas de crédito',
        description: 'Maneja tus tarjetas de crédito para relizar tus pagos.',
        imagePath: 'assets/images/credit_cards.png',
      ),
      _buildPageContent(
        title: 'Historial',
        description: 'Consulta tu historial de todas tus visitas a centros comerciales.',
        iconData: Icons.history,
      ),
    ];
  }

  Widget _buildPageContent(
      {required String title, String? imagePath, required String description, IconData? iconData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        ScreenHeader(
          title: title,
          horizontalPadding: HORIZONTAL_MARGIN,
        ),
        const SizedBox(height: 80),
        Align(
          child: Container(
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagePath,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  )
                : Icon(
                    iconData,
                    size: 200,
                    color: primary,
                  ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
          child: Text(
            description,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }

  Widget _buildPageContentSvg({
    required String title,
    required String svgPath,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        ScreenHeader(
          title: title,
          horizontalPadding: HORIZONTAL_MARGIN,
        ),
        const SizedBox(height: 80),
        Align(
          child: SvgPicture.asset(
            svgPath,
            semanticsLabel: 'Tap on phone',
            height: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
          child: Text(
            description,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

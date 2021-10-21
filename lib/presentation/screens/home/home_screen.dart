import 'dart:io';

import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/home/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/tutorial.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final settingsKey = GlobalKey();
  final transactionsKey = GlobalKey();
  final nfcButtonKey = GlobalKey();

  List<TutorialItens> tutorialItems = [];

  @override
  void initState() {
    tutorialItems.addAll({
      TutorialItens(
          globalKey: settingsKey,
          touchScreen: true,
          top: 200,
          left: 50,
          children: [
            const Text(
              'Presiona aqui para ver tus configuraciones y administrar tus tarjetas de crédito.',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            )
          ],
          widgetNext: _buildContinueTutorialButton('Presiona aqui para continuar'),
          shapeFocus: ShapeFocus.oval),
      TutorialItens(
        globalKey: transactionsKey,
        touchScreen: true,
        top: 200,
        left: 50,
        children: [
          const Text(
            'Presiona aqui para poder ver tu historial de transacciones, incluyendo las actuales.',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 100,
          )
        ],
        widgetNext: _buildContinueTutorialButton('Presiona aqui para continuar'),
        shapeFocus: ShapeFocus.oval,
      ),
      TutorialItens(
        globalKey: nfcButtonKey,
        touchScreen: true,
        top: 50,
        left: 50,
        children: [
          const Text(
            'Presiona aqui y acerca tu telefono al sensor para poder abrir la talanquera.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          )
        ],
        widgetNext: Container(),
        shapeFocus: ShapeFocus.square,
      ),
    });
    super.initState();
    Future.delayed(Duration.zero, () async {
      final sharedPreferences = await SharedPreferences.getInstance();

      final firstTimeHome = sharedPreferences.getBool('first_time_home');

      if (firstTimeHome == null || !firstTimeHome) {
        Tutorial.showTutorial(context, tutorialItems);
        await sharedPreferences.setBool('first_time_home', true);
      }
    });
  }

  Future<void> _readNfcTag(BuildContext context) async {
    // Check availability
    final isAvailable = await NfcManager.instance.isAvailable();

    await NfcManager.instance.stopSession();

    // Start Session
    if (isAvailable) {
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        alertMessage: 'Acerca tu dispositivo al sensor NFC',
        onDiscovered: (NfcTag tag) async {
          if (Platform.isIOS) {
            // Stop Session
            await NfcManager.instance.stopSession();
          }

          var id = '';

          if (Platform.isIOS) {
            final miFare = MiFare.from(tag);
            id = miFare!.identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
          } else {
            final nfcA = NfcA.from(tag);
            id = nfcA!.identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
          }

          // Llamada para abrir talanquera
          utils.showLoading(context);
          await context.read<HomeCubit>().enterOrExitMall(tagId: id);

          if (Platform.isAndroid) {
            // Stop Session
            await NfcManager.instance.stopSession();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        leading: IconButton(
          key: transactionsKey,
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
            key: settingsKey,
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (_) => sl<HomeCubit>(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded) {
            utils.hideLoading(context);
            if (state.transaction.amount == null) {
              utils.showCustomAlert(
                context,
                img: 'assets/images/success.png',
                title: '¡Bienvenido a ${state.transaction.mall.name}!',
                message: 'Disfruta tu visita.',
                barrierDismissible: false,
              );
            } else {
              utils.showCustomAlert(
                context,
                img: 'assets/images/success.png',
                title: '¡Gracias por visitar ${state.transaction.mall.name}!',
                message:
                    'Esperamos que hayas disfrutado tu visita. Tu monto a pagar es de Q. ${state.transaction.amount!.toStringAsFixed(2)}',
                barrierDismissible: false,
              );
            }
          } else if (state is HomeError) {
            utils.hideLoading(context);
            final failure = state.failure;
            if (failure is UnauthorizedFailure) {
              utils.showUnauthorizedAlert(context, state.failure.message);
            } else if (failure is ServerFailure) {
              if (failure.code == 0) {
                utils.showCustomAlert(
                  context,
                  img: 'assets/images/internet-failure.png',
                  title: 'Lo sentimos...',
                  message: state.message,
                  barrierDismissible: false,
                );
              } else {
                utils.showCustomAlert(
                  context,
                  img: 'assets/images/unauthorized.png',
                  title: 'Lo sentimos...',
                  message: state.message,
                  barrierDismissible: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: InkWell(
                    key: nfcButtonKey,
                    onTap: () => _readNfcTag(context),
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
          );
        },
      ),
    );
  }

  Widget _buildContinueTutorialButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

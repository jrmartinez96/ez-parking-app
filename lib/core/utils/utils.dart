import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/presentation/widgets/custom_dialog.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';

void showDefaultAlert(BuildContext context, message) {
  showCustomAlert(
    context,
    img: 'assets/images/alert_circle_error.png',
    title: 'Ocurrio un error...',
    message: message,
    button: 'Aceptar',
    onPressed: () => Navigator.of(context).pop(),
  );
}

/// Muestra un dialogo en pantalla para indicar que la sesión del usuario a expirado.
void showUnauthorizedAlert(BuildContext context, message) {
  showCustomAlert(
    context,
    img: 'assets/images/unauthorized.png',
    title: 'Sesión expirada',
    message: message,
    button: 'Aceptar',
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    },
  );
}

/// Muestra un dialogo en el app y permite customizar todas las propiedades
void showCustomAlert(
  BuildContext context, {
  required String img,
  required String title,
  required String message,
  String button = 'Aceptar',
  void Function()? onPressed,
  bool barrierDismissible = true,
  void Function()? onClose,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => CustomDialog(
      image: img,
      onClose: onClose,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _defaultDialogChild(
          context,
          title: title,
          message: message,
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          button: button,
        ),
      ),
    ),
  );
}

List<Widget> _defaultDialogChild(
  BuildContext context, {
  required String title,
  required String message,
  void Function()? onPressed,
  required String button,
}) {
  return [
    Text(
      title,
      style: Theme.of(context).textTheme.headline3,
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 20),
    Text(
      message,
      style: Theme.of(context).textTheme.bodyText1,
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 20),
    SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        title: button,
      ),
    ),
    const SizedBox(height: 20),
  ];
}

Widget buildLoading(BuildContext context, {double? height}) {
  return Container(
    height: height,
    alignment: Alignment.center,
    child: const CircularProgressIndicator(),
  );
}

// Loading
void showLoading(BuildContext context, {String? message}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            child: Container(
              height: 100,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(message ?? 'Cargando...'),
                  ),
                  const CircularProgressIndicator(
                    color: primary,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

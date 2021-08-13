import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';

class PopUpMessage extends StatelessWidget {
  PopUpMessage({
    Key? key,
    this.imagePath = '',
  }) : super(key: key);

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.51,
        width: MediaQuery.of(context).size.height * 0.51,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(imagePath),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: 59,
              width: 195,
              child: const Text(
                '¡Contraseña temporal enviada!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyColor),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: const Text(
                'La contraseña temporal a sido enviada al correo relacionado a tu cuenta. Si por alguna razón no la recibes por favor vuelve a intentar.',
                style: TextStyle(fontSize: 15, color: contextColor),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            PrimaryButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
              title: 'Iniciar Sesión',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              height: 44,
              width: 305,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: const BorderSide(width: 2.0, color: primary),
                    ),
                  ),
                ),
                child: const Text(
                  'Volver a enviar',
                  style: TextStyle(color: primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

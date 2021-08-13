import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/core/framework/decorations.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;

class VoucherScreen extends StatefulWidget {
  VoucherScreen({Key? key}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  // Screenshot controller
  final _screenshotController = ScreenshotController();

  void onSave() async {
    // Construccion de path en donde se ira a guardar la imagen del comprobante
    final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.jpg').replaceAll(' ', '-').replaceAll(':', '');

    // Captura del comprobante
    final file = await _screenshotController.captureAndSave(path, pixelRatio: 1.5);

    if (await Permission.storage.request().isGranted) {
      await ImageGallerySaver.saveFile(file!);

      utils.showCustomAlert(
        this.context,
        img: 'assets/images/success.png',
        title: '¡Descarga exitosa!',
        message: 'Tu comprobante se decargó con éxito.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as VoucherScreenArgs;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
            child: ScreenHeader(
              title: args.title,
              textAlign: TextAlign.start,
            ),
          ),
          Screenshot(
            controller: _screenshotController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  _buildVoucherCard(args: args),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
            child: PrimaryButton(
              title: 'Descargar',
              onPressed: onSave,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildVoucherCard({required VoucherScreenArgs args}) {
    final dateString = voucherDateTime(args.dateTime);
    var fieldsWidgets = <Widget>[];

    for (var i = 0; i < args.fields.length; i++) {
      final field = args.fields[i];
      fieldsWidgets.add(_buildVoucherField(title: field.title, value: field.value));
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'COMPROBANTE',
              style: Theme.of(this.context).textTheme.headline3,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              dateString,
              style: Theme.of(this.context).textTheme.bodyText1!.copyWith(fontSize: 16, color: lightGreyColor),
            ),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: lightGreyColor),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Datos',
                  style: Theme.of(this.context).textTheme.headline3!.copyWith(fontSize: 16),
                ),
                ...fieldsWidgets,
                const SizedBox(height: 20),
                Text(
                  'Autorización: ${args.authorization}',
                  style: Theme.of(this.context).textTheme.bodyText1!.copyWith(fontSize: 16, color: lightGreyColor),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherField({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(this.context).textTheme.bodyText1,
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            width: 140,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(this.context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Convert datetime to string
  String voucherDateTime(DateTime dateTime) {
    final day = dateTime.day > 9 ? '${dateTime.day}' : '0${dateTime.day}';
    final month = dateTime.month > 9 ? '${dateTime.month}' : '0${dateTime.month}';
    final year = '${dateTime.year}';
    final hour = dateTime.hour > 9 ? '${dateTime.hour}' : '0${dateTime.hour}';
    final minute = dateTime.minute > 9 ? '${dateTime.minute}' : '0${dateTime.minute}';

    final dateString = '$hour:$minute $day/$month/$year';

    return dateString;
  }
}

class VoucherScreenArgs {
  VoucherScreenArgs({required this.title, required this.dateTime, required this.authorization, required this.fields});
  final String title;
  final DateTime dateTime;
  final String authorization;
  final List<VoucherField> fields;
}

class VoucherField {
  VoucherField({required this.title, required this.value});

  final String title;
  final String value;
}

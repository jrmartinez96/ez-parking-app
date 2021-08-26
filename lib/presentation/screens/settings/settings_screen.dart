import 'package:ez_parking_app/presentation/widgets/cards/menu_item_card.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await _storage.delete(key: 'ACCESS_TOKEN');
              await _storage.delete(key: 'REFRESH_TOKEN');
              await Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            icon: const Icon(
              Icons.power_settings_new,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const ScreenHeader(
              title: 'Ajustes',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            MenuItemCard(
              title: 'Mis Tarjetas',
              description: 'Agrega, modifica y elimina tus tarjetas',
              onPressed: () => Navigator.of(context).pushNamed('/credit_cards'),
              imagePath: 'assets/images/credit_cards.png',
            )
          ],
        ),
      ),
    );
  }
}

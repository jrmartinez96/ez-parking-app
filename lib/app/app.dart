// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ez_parking_app/core/theme/app_theme.dart';
import 'package:ez_parking_app/router/routing.dart';
import 'package:event_bus/event_bus.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.onBoarding, required this.isRefreshToken}) : super(key: key);

  final int onBoarding;
  final bool isRefreshToken;

  @override
  Widget build(BuildContext context) {
    final eventBus = EventBus(sync: true);
    var initialRoute = 'welcome';
    if (onBoarding == 1) {
      if (isRefreshToken) {
        initialRoute = '/home';
      } else {
        initialRoute = '/login';
      }
    }

    return MaterialApp(
      theme: ezParkingAppTheme(context),
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      initialRoute: initialRoute,
      routes: getApplicationRoutes(eventBus),
    );
  }
}

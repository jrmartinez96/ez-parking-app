// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:ez_parking_app/domain/use_cases/auth/get_on_boarding.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:ez_parking_app/app/app.dart';
import 'package:ez_parking_app/app/app_bloc_observer.dart';

import 'package:ez_parking_app/dependency_injection/injection_container.dart' as di;

import 'package:ez_parking_app/dependency_injection/injection_container.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Inyeccion de dependencias
  await di.init();

  // SharedPreferences
  final onBoarding = isFirstLaunch();

  runZonedGuarded(
    () => runApp(App(onBoarding: onBoarding)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

/// Regresa `true` si es la primera vez que se abre el app.
int isFirstLaunch() {
  final getOnBoarding = GetOnBoarding(sl());
  return getOnBoarding();
}

// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:ez_parking_app/app/app.dart';
import 'package:ez_parking_app/app/app_bloc_observer.dart';

import 'package:ez_parking_app/dependency_injection/injection_container.dart' as di;

// ignore: avoid_void_async
void main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Inyeccion de dependencias
  await di.init();

  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

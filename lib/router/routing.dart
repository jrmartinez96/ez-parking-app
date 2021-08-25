import 'package:event_bus/event_bus.dart';
import 'package:ez_parking_app/presentation/screens/auth/register_screen.dart';
import 'package:ez_parking_app/presentation/screens/auth/reset_password_screen.dart';
import 'package:ez_parking_app/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ez_parking_app/presentation/screens/auth/login_screen.dart';
import 'package:ez_parking_app/presentation/screens/voucher/voucher_screen.dart';
import 'package:ez_parking_app/presentation/screens/welcome.dart';

// Este metodo se encarga de regresar todas las rutas existentes dentro de la app.
Map<String, WidgetBuilder> getApplicationRoutes(EventBus eventBus) {
  return <String, WidgetBuilder>{
    '/welcome': (context) => WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/reset_password': (context) => ResetPasswordScreen(),
    '/home': (context) => HomeScreen(),
    '/voucher': (context) => const VoucherScreen(),
  };
}

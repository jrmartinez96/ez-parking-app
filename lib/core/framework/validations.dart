import 'package:flutter/cupertino.dart';

String? validateUsername(String value, BuildContext context) {
  if (value.length < 3) {
    return 'Usuario inválido';
  }
  return null;
}

String? validateEmail(String value) {
  const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = RegExp(pattern);
  return !regex.hasMatch(value) ? 'Correo inválido' : null;
}

String? validatePhone(String value, {String? dial}) {
  if (value.isEmpty) {
    return 'Número de teléfono inválido';
  }
  String pattern;
  switch (dial) {
    case '+1':
      pattern = r'^[0-9]{7,10}$';
      break;
    case '+502':
      pattern = r'^[0-9]{8}$';
      break;
    default:
      pattern = r'^[0-9]{7,10}$';
      break;
  }

  final regex = RegExp(pattern);
  return !regex.hasMatch(value) ? 'Número de teléfono inválido' : null;
}

String? validatePassword(String value) {
  if (value.length < 6) {
    return 'Contraseña debe de tener más de 6 caracteres.';
  }
  return null;
}

String? validatePasswords(String password1, String password2) {
  return password1 != password2 ? 'Contraseñas no son iguales' : null;
}

String? isEmpty(String value) {
  return value.isEmpty ? 'Campo obligatorio' : null;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/core/framework/validations.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/auth/login/login_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';
import 'package:ez_parking_app/presentation/widgets/primary_textfield.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form
  final _formKey = GlobalKey<FormState>();
  bool autovalidateOnIteraction = false;

  // Keyboard listener
  final _keyboardVisibilityController = KeyboardVisibilityController();
  bool _isKeyboardVisible = false;
  StreamSubscription? onChangeSub;

  @override
  void initState() {
    onChangeSub = _keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    onChangeSub?.cancel();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().loginTemp(email: emailController.text.trim(), password: passwordController.text);
    } else {
      setState(() {
        autovalidateOnIteraction = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoaded) {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            } else if (state is LoginError) {
              utils.showCustomAlert(
                context,
                img: 'assets/images/unauthorized.png',
                title: 'Lo sentimos...',
                message: state.message,
                barrierDismissible: false,
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<LoginCubit>().returnToInitial();
                },
              );
            }
          },
          builder: _buildForm,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, LoginState state) {
    Widget form;
    if (state is LoginLoading) {
      form = _buildLoading();
    } else {
      form = _buildFields(context);
    }

    return Stack(
      children: [
        if (!_isKeyboardVisible) _buildBottom() else Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * (_isKeyboardVisible ? 0.09 : 0.17)),
              const ScreenHeader(
                title: 'Iniciar Sesión',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              form
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFields(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateOnIteraction ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      child: Column(
        children: [
          PrimaryTextfield(
            controller: emailController,
            hintText: 'Correo electrónico',
            verticalMargin: 0,
            horizontalMargin: 0,
            customValidator: validateEmail,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          PrimaryTextfield(
            controller: passwordController,
            hintText: 'Contraseña',
            obscureText: true,
            verticalMargin: 0,
            horizontalMargin: 0,
            customValidator: validatePassword,
          ),
          _buildSignInButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          PrimaryButton(onPressed: () => _onLogin(context), title: 'Iniciar Sesión'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          '¿Olvidaste tu contraseña? Recuperar.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
        child: CircularProgressIndicator(
      color: primary,
    ));
  }
}

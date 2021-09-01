import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/core/framework/validations.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/auth/reset_password/reset_password_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';
import 'package:ez_parking_app/presentation/widgets/primary_textfield.dart';
import 'package:ez_parking_app/presentation/widgets/screen_description.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Controller
  final _emailController = TextEditingController();

  // Form
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  void _onResetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().resetPassword(email: _emailController.text);
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ResetPasswordCubit>(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoaded) {
            utils.showCustomAlert(
              context,
              img: 'assets/images/success.png',
              title: 'Correo enviado con éxito',
              message:
                  'Revisa la bandeja de entrada de tu correo y sigue las instrucciones para poder reiniciar tu contraseña',
              barrierDismissible: false,
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/login')),
            );
          } else if (state is ResetPasswordError) {
            final failure = state.failure;
            if (failure is ServerFailure) {
              if (failure.code == 0) {
                utils.showCustomAlert(
                  context,
                  img: 'assets/images/internet-failure.png',
                  title: 'Lo sentimos...',
                  message: state.message,
                  barrierDismissible: false,
                );
              } else {
                utils.showCustomAlert(
                  context,
                  img: 'assets/images/unauthorized.png',
                  title: 'Lo sentimos...',
                  message: state.message,
                  barrierDismissible: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ResetPasswordState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
      children: [
        const ScreenHeader(
          title: 'Olvidé mi contraseña',
          textAlign: TextAlign.start,
        ),
        const ScreenDescription(description: 'Te enviaremos un correo para que puedas reiniciar tu contraseña.'),
        Form(
          key: _formKey,
          autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: PrimaryTextfield(
            controller: _emailController,
            hintText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            customValidator: validateEmail,
            horizontalMargin: 0,
          ),
        ),
        const SizedBox(height: 40),
        if (state is ResetPasswordLoading)
          Column(
            children: const [
              SizedBox(height: 40),
              LoadingCircularProgressIndicator(),
            ],
          )
        else
          PrimaryButton(
            title: 'Enviar correo',
            onPressed: () {
              _onResetPassword(context);
            },
          ),
      ],
    );
  }
}

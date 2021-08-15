import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/core/framework/validations.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/auth/signup/signup_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';
import 'package:ez_parking_app/presentation/widgets/primary_textfield.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:ez_parking_app/presentation/widgets/sliver_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form
  final _formKey = GlobalKey<FormState>();
  bool autoValidateForm = false;

  void onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().signupUser(
            email: _emailController.text,
            name: _nameController.text,
            lastname: _lastNameController.text,
            password: _passwordController.text,
          );
    } else {
      setState(() {
        autoValidateForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoaded) {
            final signupSuccess = state.signupSuccess;
            utils.showCustomAlert(
              context,
              img: 'assets/images/success.png',
              title: '¡Felicidades ${signupSuccess.name}!',
              message: 'Tu cuenta ha sido creada con éxito.',
              barrierDismissible: false,
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/login'));
              },
            );
          } else if (state is SignupError) {
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
        },
        builder: (context, state) {
          return Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SignupState state) {
    var formOrLoading = <Widget>[];
    if (state is SignupLoading) {
      formOrLoading = [
        const SizedBox(height: 40),
        const LoadingCircularProgressIndicator(),
      ];
    } else {
      formOrLoading = _buildForm();
    }

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        const SliverAppBar(),
        Form(
          key: _formKey,
          autovalidateMode: autoValidateForm ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: SliverList(
            delegate: SliverChildListDelegate(
              [
                const ScreenHeader(
                  title: 'Registro',
                  textAlign: TextAlign.start,
                  horizontalPadding: HORIZONTAL_MARGIN,
                ),
                ...formOrLoading
              ],
            ),
          ),
        ),
        if (state is SignupLoading)
          SliverToBoxAdapter(child: Container())
        else
          SliverBottomButton(
            title: 'Registrarme',
            onPressed: () {
              onSignUp(context);
            },
          ),
      ],
    );
  }

  List<Widget> _buildForm() {
    return [
      const SizedBox(height: 40),
      PrimaryTextfield(
        controller: _nameController,
        hintText: 'Nombre',
        required: true,
      ),
      const SizedBox(height: 10),
      PrimaryTextfield(
        controller: _lastNameController,
        hintText: 'Apellido',
        required: true,
      ),
      const SizedBox(height: 10),
      PrimaryTextfield(
        controller: _emailController,
        hintText: 'Correo',
        required: true,
        customValidator: validateEmail,
      ),
      const SizedBox(height: 10),
      PrimaryTextfield(
          controller: _passwordController,
          hintText: 'Contraseña',
          required: true,
          obscureText: true,
          customValidator: validatePassword),
      const SizedBox(height: 10),
      PrimaryTextfield(
        controller: _confirmPasswordController,
        hintText: 'Confirmar contraseña',
        required: true,
        obscureText: true,
        customValidator: (text) {
          if (_passwordController.text != _confirmPasswordController.text) {
            return 'Contraseñas no son iguales';
          }
          return validatePassword(text);
        },
      ),
    ];
  }
}

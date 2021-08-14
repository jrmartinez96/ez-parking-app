import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/presentation/widgets/primary_textfield.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:ez_parking_app/presentation/widgets/sliver_bottom_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        const SliverAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const ScreenHeader(
                title: 'Registro',
                textAlign: TextAlign.start,
                horizontalPadding: HORIZONTAL_MARGIN,
              ),
              const SizedBox(height: 40),
              PrimaryTextfield(
                controller: _nameController,
                hintText: 'Nombre',
                required: true,
              ),
              const SizedBox(height: 10),
              PrimaryTextfield(
                controller: _emailController,
                hintText: 'Correo',
                required: true,
              ),
              const SizedBox(height: 10),
              PrimaryTextfield(
                controller: _passwordController,
                hintText: 'Contraseña',
                required: true,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              PrimaryTextfield(
                controller: _confirmPasswordController,
                hintText: 'Confirmar contraseña',
                required: true,
                obscureText: true,
              ),
            ],
          ),
        ),
        SliverBottomButton(
          title: 'Registrarme',
          onPressed: () {},
        ),
      ],
    );
  }
}

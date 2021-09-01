import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/presentation/bloc/credit_cards/create_credit_card/create_credit_card_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';
import 'package:ez_parking_app/presentation/widgets/primary_button.dart';
import 'package:ez_parking_app/presentation/widgets/primary_textfield.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;

class CreateCreditCardScreen extends StatefulWidget {
  CreateCreditCardScreen({Key? key}) : super(key: key);

  @override
  _CreateCreditCardScreenState createState() => _CreateCreditCardScreenState();
}

class _CreateCreditCardScreenState extends State<CreateCreditCardScreen> {
  // Controllers
  final _numberController = TextEditingController();
  final _holderController = TextEditingController();
  final _expDateController = TextEditingController();

  // Form
  final _formKey = GlobalKey<FormState>();
  bool _autovalidateForm = false;

  void _onAddCreditCard(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<CreateCreditCardCubit>().createCreditCard(
            cardNumber: _numberController.text,
            holder: _holderController.text,
            expirationDate: _expDateController.text,
          );
    } else {
      setState(() {
        _autovalidateForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (_) => sl<CreateCreditCardCubit>(),
      child: BlocConsumer<CreateCreditCardCubit, CreateCreditCardState>(
        listener: (context, state) {
          if (state is CreateCreditCardLoaded) {
            utils.showCustomAlert(
              context,
              img: 'assets/images/success.png',
              title: '¡Felicidades!',
              message: 'Tu tarjeta ha sido agregada con éxito.',
              barrierDismissible: false,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, state.creditCard);
              },
            );
          } else if (state is CreateCreditCardError) {
            final failure = state.failure;
            if (failure is UnauthorizedFailure) {
              utils.showUnauthorizedAlert(context, state.failure.message);
            } else if (failure is ServerFailure) {
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
          var form = <Widget>[];
          if (state is CreateCreditCardLoading) {
            form = [const LoadingCircularProgressIndicator()];
          } else {
            form = _buildForm(context);
          }
          return Form(
            key: _formKey,
            autovalidateMode: _autovalidateForm ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: ListView(
              children: [
                const ScreenHeader(title: 'Agregar tarjeta', textAlign: TextAlign.start, horizontalPadding: 20),
                const SizedBox(height: 20),
                _buildCard(),
                const SizedBox(height: 40),
                ...form,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard() {
    return CreditCard(
      cardNumber: _numberController.text,
      cardExpiry: _expDateController.text,
      cardHolderName: _holderController.text,
      bankName: 'Tarjeta de crédito',
      cardType: CardType.visa, // Optional if you want to override Card Type
      frontBackground: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: primary,
      ),
      backBackground: CardBackgrounds.white,
      showShadow: true,
      textExpDate: 'Fecha Exp.',
      textName: 'Nombre',
    );
  }

  List<Widget> _buildForm(BuildContext context) {
    return [
      _buildTextField(
        controller: _numberController,
        title: 'Número de la tarjeta',
        hint: 'XXXX XXXX XXXX XXXX',
        keyboardType: TextInputType.number,
        inputFormatters: [CreditCardNumberInputFormatter(), LengthLimitingTextInputFormatter(19)],
        customValidator: (value) {
          if (!isCardValidNumber(value)) {
            return 'Este número no es válido.';
          }
          return null;
        },
        onChange: (value) {
          setState(() {});
        },
      ),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: _buildTextField(
              controller: _holderController,
              title: 'Nombre',
              hint: '',
              onChange: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: _buildTextField(
              controller: _expDateController,
              title: 'Fecha de exp.',
              hint: 'MM/YY',
              inputFormatters: [CreditCardExpirationDateFormatter()],
              customValidator: (value) {
                if (value.length != 5) {
                  return 'Esta fecha no es válida.';
                }
                return null;
              },
              onChange: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: PrimaryButton(
          title: 'Agregar',
          onPressed: () {
            _onAddCreditCard(context);
          },
        ),
      )
    ];
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String title,
    required String hint,
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String)? customValidator,
    void Function(String)? onChange,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          PrimaryTextfield(
            controller: controller,
            hintText: hint,
            required: true,
            horizontalMargin: 0,
            keyboardType: keyboardType,
            textCapitalization: TextCapitalization.words,
            customValidator: customValidator,
            inputFormatters: inputFormatters ?? [],
            onChanged: onChange,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

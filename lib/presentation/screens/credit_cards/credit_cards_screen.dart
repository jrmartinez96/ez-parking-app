import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/domain/entities/credit_cards/credit_card.dart';
import 'package:ez_parking_app/presentation/bloc/credit_cards/credit_cards/credit_cards_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/cards/menu_item_card.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreditCardsScreen extends StatefulWidget {
  CreditCardsScreen({Key? key}) : super(key: key);

  @override
  _CreditCardsScreenState createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  final _refreshController = RefreshController();
  List<CreditCard> _creditCards = [];

  void _onRefresh(BuildContext context) {
    _refreshController.refreshCompleted();
    context.read<CreditCardsCubit>().getCreditCards();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CreditCardsCubit>()..getCreditCards(),
      child: BlocConsumer<CreditCardsCubit, CreditCardsState>(
        listener: (context, state) {
          if (state is CreditCardsLoaded) {
            _creditCards = state.creditCards;
          } else if (state is CreditCardsError) {
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
          var creditCards = <Widget>[];
          if (state is CreditCardsLoading) {
            creditCards = [const LoadingCircularProgressIndicator()];
          } else if (state is CreditCardsLoaded) {
            creditCards = _buildCreditCards();
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: _onCreateCreditCard,
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                )
              ],
            ),
            body: SmartRefresher(
              controller: _refreshController,
              header: WaterDropHeader(complete: Container(), waterDropColor: primary),
              onRefresh: () => _onRefresh(context),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const ScreenHeader(
                    title: 'Mis tarjetas',
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 40),
                  ...creditCards
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCreditCards() {
    if (_creditCards.isEmpty) {
      return [
        const Icon(Icons.error_outline, size: 40, color: Colors.grey),
        const SizedBox(height: 20),
        Text(
          'No tienes tarjetas de credito registradas.',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        )
      ];
    }

    return _creditCards.map<Widget>((creditCard) {
      return MenuItemCard(
        title: creditCard.holder,
        description: '${_obscureCreditCardNumber(creditCard.number)}\n Exp. ${creditCard.expirationDate}',
        imagePath: 'assets/images/credit_cards.png',
        onPressed: () => _onEditCreditCard(creditCard),
      );
    }).toList();
  }

  Future<void> _onCreateCreditCard() async {
    final creditCard = await Navigator.of(context).pushNamed('/create_credit_card');

    if (creditCard != null) {
      setState(() {
        _creditCards = [..._creditCards, creditCard as CreditCard];
      });
    }
  }

  Future<void> _onEditCreditCard(CreditCard creditCard) async {
    final creditCardResponse = await Navigator.of(context).pushNamed('/edit_credit_card', arguments: creditCard);

    if (creditCardResponse != null) {
      final creditCardObject = creditCardResponse as CreditCard;
      if (creditCardObject.id == 0) {
        final removeIndex = _creditCards.indexWhere((element) => element.id == creditCard.id);
        _creditCards.removeAt(removeIndex);
        setState(() {});
      } else {
        final updateIndex = _creditCards.indexWhere((element) => element.id == creditCard.id);
        _creditCards[updateIndex] = creditCardObject;
        setState(() {});
      }
    }
  }

  String _obscureCreditCardNumber(String cardNumber) {
    var numberObscure = '';

    for (var i = 0; i < cardNumber.length; i++) {
      final character = cardNumber[i];

      if (i > 4 && i < (cardNumber.length - 4) && character != ' ') {
        numberObscure = '$numberObscure*';
      } else {
        numberObscure = '$numberObscure$character';
      }
    }

    return numberObscure;
  }
}

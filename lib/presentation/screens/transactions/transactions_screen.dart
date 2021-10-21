import 'package:ez_parking_app/core/errors/failure.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/constants.dart';
import 'package:ez_parking_app/dependency_injection/injection_container.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/presentation/bloc/transactions/transactions/transactions_cubit.dart';
import 'package:ez_parking_app/presentation/widgets/cards/transaction_card.dart';
import 'package:ez_parking_app/presentation/widgets/loading_circular_progress_indicator.dart';
import 'package:ez_parking_app/presentation/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ez_parking_app/core/utils/utils.dart' as utils;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _refreshController = RefreshController();
  ScrollController _transactionsScrollController = ScrollController();
  String? _nextPage;
  late BuildContext _providerContext;
  TransactionsState? _providerState;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    _transactionsScrollController = ScrollController()..addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _transactionsScrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    if (_nextPage != null &&
        _providerState is! TransactionsLoading &&
        _transactionsScrollController.position.maxScrollExtent - 200 < _transactionsScrollController.offset) {
      _providerContext.read<TransactionsCubit>().getTransactions(url: _nextPage);
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<TransactionsCubit>().getTransactions();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (_) => sl<TransactionsCubit>()..getTransactions(),
      child: BlocConsumer<TransactionsCubit, TransactionsState>(
        listener: (context, state) {
          _providerContext = context;
          _providerState = state;
          if (state is TransactionsLoaded) {
            _nextPage = state.transactionQuery.next;
            if (state.transactionQuery.previous == null) {
              _transactions = state.transactionQuery.transactions;
            } else {
              _transactions = [..._transactions, ...state.transactionQuery.transactions];
            }
          } else if (state is TransactionsError) {
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
          setState(() {});
        },
        builder: (context, state) {
          return SmartRefresher(
            controller: _refreshController,
            header: WaterDropHeader(complete: Container(), waterDropColor: primary),
            onRefresh: () => _onRefresh(context),
            child: ListView(
              controller: _transactionsScrollController,
              padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL_MARGIN),
              children: [
                const ScreenHeader(
                  title: 'Transacciones',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 15),
                ..._buildTransactions(state),
                const SizedBox(height: 15)
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTransactions(TransactionsState state) {
    final transactionsWidget = _transactions.map<Widget>((transaction) {
      return TransactionCard(transaction: transaction);
    }).toList();

    if (state is TransactionsLoading) {
      transactionsWidget.add(const LoadingCircularProgressIndicator());
    }
    return transactionsWidget;
  }
}

import 'package:ez_parking_app/constants/months.dart';
import 'package:ez_parking_app/domain/entities/transactions/transaction_query.dart';
import 'package:ez_parking_app/presentation/widgets/cards/rounded_card.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transaction}) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.mall.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrada',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _buildDateString(transaction.enterTime),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                if (transaction.exitTime != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Salida',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _buildDateString(transaction.exitTime!),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  )
                else
                  Container(),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: transaction.amount == null ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(
                  transaction.amount == null ? 'En curso' : 'Completado',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ),
              if (transaction.amount != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Q. ${transaction.amount!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              else
                Container(),
            ],
          )
        ],
      ),
    );
  }

  String _buildDateString(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = now.difference(date);
    final diffToday = today.difference(date);

    final time = '${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}';
    final day = '${date.day < 10 ? '0${date.day}' : date.day}';
    final month = monthNames[date.month];
    final year = '${date.year}';

    if (difference.inMinutes < 1) {
      return 'Justo ahora';
    } else if (difference.inMinutes == 1) {
      return 'Hace ${difference.inMinutes} minuto';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inHours == 1) {
      return 'Hace ${difference.inHours} hora';
    } else if (diffToday.inHours < 0) {
      return 'Hace ${difference.inHours} horas';
    } else if (diffToday.inHours < 24) {
      return 'Ayer a las $time';
    }

    return '$day de $month del $year a las $time';
  }
}

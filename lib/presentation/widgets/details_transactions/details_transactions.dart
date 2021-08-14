import 'package:flutter/material.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/presentation/widgets/details_transactions/fields_transactions.dart';

class TransactionsContainer extends StatelessWidget {
  const TransactionsContainer({
    Key? key,
    required this.fields,
  }) : super(key: key);

  final List<FieldsTransactions> fields;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: primary), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: buildfields(),
      ),
    );
  }

  List<Widget> buildfields() {
    final fieldsWidget = <Widget>[];
    // ignore: avoid_function_literals_in_foreach_calls
    fields.forEach((field) => fieldsWidget.add(FieldsTransactions(title: field.title, value: field.value)));
    return fieldsWidget;
  }
}

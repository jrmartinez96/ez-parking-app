class TransactionQuery {
  TransactionQuery({
    required this.next,
    required this.previous,
    required this.transactions,
  });

  final String? next;
  final String? previous;
  final List<Transaction> transactions;
}

class Transaction {
  Transaction({
    required this.id,
    required this.mall,
    required this.enterTime,
    required this.exitTime,
    required this.amount,
  });

  final String id;
  final Mall mall;
  final DateTime enterTime;
  final DateTime? exitTime;
  final double? amount;
}

class Mall {
  Mall({
    required this.name,
    required this.address,
  });

  final String name;
  final String address;
}

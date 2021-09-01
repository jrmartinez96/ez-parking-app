class CreditCard {
  CreditCard({
    required this.number,
    required this.holder,
    required this.expirationDate,
    required this.id,
  });

  final String number;
  final String holder;
  final String expirationDate;
  final int id;
}

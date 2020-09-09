class Money {
  double amount;
  double founder;
  double sundries;

  Money({this.amount, this.founder, this.sundries});

  Money.fromJson(Map<String, dynamic> json) {
    this.amount = double.parse(json['amount']);
    this.founder = double.parse(json['founder']);
    this.sundries = double.parse(json['sundries']);
  }
}

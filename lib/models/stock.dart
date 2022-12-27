class Stock {
  final String ticker;
  final String name;

  Stock(this.ticker, this.name);

  static Stock fromJson(Map<String, dynamic> json) {
    return Stock(json['Ticker'], json['Name']);
  }
}

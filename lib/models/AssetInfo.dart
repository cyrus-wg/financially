class AssetInfo {
  final String ticker;
  final String name;
  final String exchange;
  final String type;
  late bool watched;

  AssetInfo(this.ticker, this.name, this.exchange, this.type);

  static AssetInfo fromJson(Map<String, dynamic> json) {
    return AssetInfo(
        json['Ticker'], json['Name'], json['Exchange'], json['Type']);
  }
}

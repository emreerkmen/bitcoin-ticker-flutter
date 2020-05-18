import 'package:bitcoin_ticker/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const bitcoinAverageUrl =
    "https://apiv2.bitcoinaverage.com/indices/global/ticker";

class CoinData {
  String equal;
  List<String> pairs;
  Map<String, double> cryptoPrices = {};

  void setEqual(String equal) {
    this.equal = equal;
  }

  Future<dynamic> getCoinIndices(String coinType) async {
    NetworkHelper networkHelper = NetworkHelper('$bitcoinAverageUrl/$coinType');

    var coinIndices = await networkHelper.getData();

    return coinIndices;
  }

  void getPairs() {
    pairs = cryptoList.map<String>((value) => '$value$equal').toList();
  }

  Future setPrices(String equal) async {
    setEqual(equal);
    getPairs();
    for (var cryp in cryptoList) {
      print(cryp + equal);
      var coinData = await getCoinIndices('$cryp$equal');
      if (coinData == null) {
        cryptoPrices[cryp] = 0;
      } else {
        var price = coinData['ask'];
        print(price);
        cryptoPrices[cryp] = price;
      }
    }
  }
}

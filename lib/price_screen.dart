import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'dart:io' show Platform;
//import 'dart:io' hide Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownVale = currenciesList.first;
  double priceData;
  var coinIndicesData;
  CoinData coinData = CoinData();

  List<DropdownMenuItem> getDropdownItems() {
    return currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  DropdownButton<String> androidDropdownButton() {
    return DropdownButton<String>(
      value: dropdownVale,
      items: getDropdownItems(),
      onChanged: (newValue) async {
        await coinData.setPrices(newValue);
        setState(()  {
          dropdownVale = newValue;
        });
      },
    );
  }

  List<Text> getPickerText() {
    return currenciesList.map<Text>((String value) => Text(value)).toList();
  }

  CupertinoPicker iOSPickerButton() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedChanged) {
        print(selectedChanged);
      },
      children: getPickerText(),
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPickerButton();
    } else if (Platform.isAndroid) {
      return androidDropdownButton();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var currenci in cryptoList)
            CoinCard(
              coin: currenci,
              price: coinData.cryptoPrices[currenci] ?? 0,
              equal: dropdownVale,
            ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? iOSPickerButton()
                : androidDropdownButton(), //getPicker(),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({this.coin, this.price, this.equal});

  final String coin;
  final double price;
  final String equal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = $price $equal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

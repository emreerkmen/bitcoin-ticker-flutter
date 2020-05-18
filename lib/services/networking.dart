import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    //print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      // var longtitude = jsonDecode(data)['coord']['lon'];

      // print(longtitude);

      // var weatherDescription = jsonDecode(data)['weather'][0]['description'];

      // print(weatherDescription);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
      //throw 'Problem with the get request';
      return null;
    }
  }
}

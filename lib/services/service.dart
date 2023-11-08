import 'dart:convert';

import '../model/quote_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<QuoteModel>> getQuotes({required String category,required String numberOfQuotes}) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://api.api-ninjas.com/v1/quotes?category=$category&limit=$numberOfQuotes',
      ),
        headers: {
          'X-Api-Key': 'ut/m60UHmar+2Ei6eYxeMw==gOcT90qa0O8IHdjT',

    },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<QuoteModel> quotes = [];
      for (int i = 0; i < data.length; i++) {
        quotes.add(QuoteModel.fromJson(data[i]));
      }
      print(quotes.length);
      return quotes;
    } else {
      throw Exception(
          'there was an error with status code = ${response.statusCode}');
    }
  }
}

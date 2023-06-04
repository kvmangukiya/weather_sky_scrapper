import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/search_city_model.dart';
import '../utils/api_utils.dart';
import '../utils/functions.dart';

class SearchCityProvider extends ChangeNotifier {
  List<SearchCityModel> searchCityModel = [];

  Future<List<SearchCityModel>> searchCity(String searchText) async {
    searchCityModel.clear();
    // http://api.weatherapi.com/v1/search.json?key=b94da5b2d72e4e26a5d132250233105&q=Surat
    Uri url = Uri.parse("${WeatherApiUtils.baseUrl}"
        "/${WeatherApiUtils.searchApi}"
        "?key=${WeatherApiUtils.key}"
        "&q=$searchText");
    var response1 = await http.get(url);
    if (response1.statusCode == 200) {
      searchCityModel = searchCityModelFromJson(response1.body);
    } else {
      myToast("Something went wrong!");
    }
    return searchCityModel;
  }
}

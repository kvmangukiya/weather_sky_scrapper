// To parse this JSON data, do
//
//     final searchCityModel = searchCityModelFromJson(jsonString);

import 'dart:convert';

List<SearchCityModel> searchCityModelFromJson(String str) =>
    List<SearchCityModel>.from(
        json.decode(str).map((x) => SearchCityModel.fromJson(x)));

String searchCityModelToJson(List<SearchCityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCityModel {
  int? id;
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? url;

  SearchCityModel({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) =>
      SearchCityModel(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": lon,
        "url": url,
      };
}

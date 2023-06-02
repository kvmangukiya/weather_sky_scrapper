// To parse this JSON data, do
//
//     final iPModel = ipModelFromJson(jsonString);

import 'dart:convert';

IPModel ipModelFromJson(String str) => IPModel.fromJson(json.decode(str));

String ipModelToJson(IPModel data) => json.encode(data.toJson());

class IPModel {
  String? ip;
  String? type;
  String? continentCode;
  String? continentName;
  String? countryCode;
  String? countryName;
  String? isEu;
  int? geonameId;
  String? city;
  String? region;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  IPModel({
    this.ip,
    this.type,
    this.continentCode,
    this.continentName,
    this.countryCode,
    this.countryName,
    this.isEu,
    this.geonameId,
    this.city,
    this.region,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory IPModel.fromJson(Map<String, dynamic> json) => IPModel(
        ip: json["ip"],
        type: json["type"],
        continentCode: json["continent_code"],
        continentName: json["continent_name"],
        countryCode: json["country_code"],
        countryName: json["country_name"],
        isEu: json["is_eu"],
        geonameId: json["geoname_id"],
        city: json["city"],
        region: json["region"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "type": type,
        "continent_code": continentCode,
        "continent_name": continentName,
        "country_code": countryCode,
        "country_name": countryName,
        "is_eu": isEu,
        "geoname_id": geonameId,
        "city": city,
        "region": region,
        "lat": lat,
        "lon": lon,
        "tz_id": tzId,
        "localtime_epoch": localtimeEpoch,
        "localtime": localtime,
      };
}

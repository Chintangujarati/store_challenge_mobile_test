import 'dart:convert';

StoreDetailModel storeDetailModelFromJson(String str,List<int> codeUnits) =>
    StoreDetailModel.fromJson(json.decode(utf8.decode(codeUnits)));

String storeDetailModelToJson(StoreDetailModel data) =>
    json.encode(data.toJson());

class StoreDetailModel {
  StoreDetailModel({
    required this.name,
    required this.rating,
    required this.openingTime,
    required this.closingTime,
  });

  String name;
  double rating;
  String openingTime;
  String closingTime;

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) =>
      StoreDetailModel(
        name: json["name"],
        rating: json["rating"].toDouble(),
        openingTime: json["openingTime"],
        closingTime: json["closingTime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rating": rating,
        "openingTime": openingTime,
        "closingTime": closingTime,
      };
}

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str, List<int> codeUnits) =>
    List<ProductsModel>.from(json
        .decode(utf8.decode(codeUnits))
        .map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  ProductsModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isSelected =false,
    this.qty =0,
  });

  String name;
  int price;
  String imageUrl;
  bool? isSelected;
  int? qty;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json["name"],
        price: json["price"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "imageUrl": imageUrl,
      };
}

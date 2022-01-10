import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert' show utf8;

import 'package:sample_store/apisutility/apis.dart';
import 'package:sample_store/model/products_list_model.dart';
import 'package:sample_store/model/store_detail_model.dart';
import 'package:sample_store/notifier/store_notifier.dart';

class APIManager {
  Future<StoreDetailModel?> getStoreDetailApi() async {
    var client = http.Client();
    var storeDetailModel;
    try {
      var response = await client.get(Uri.parse(Apis.storeinfo));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(utf8.decode(response.bodyBytes));
        print(jsonMap);
        storeDetailModel =
            storeDetailModelFromJson(jsonString, response.bodyBytes);

        print(storeDetailModel);
      }
    } catch (e) {
      return storeDetailModel;
    }
    return storeDetailModel;
  }

  Future<List<ProductsModel>> getProductsApi() async {
    var client = http.Client();
    var productsList;
    try {
      var response = await client.get(Uri.parse(Apis.products));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List<dynamic> jsonMap = json.decode(utf8.decode(response.bodyBytes));
        print(jsonMap);
        productsList = productsModelFromJson(jsonString, response.bodyBytes);
        print(productsList);
      }
    } catch (e) {
      return productsList;
    }
    return productsList;
  }

  Future<String> postOrderApi(
      BuildContext context, String devliveryAddress) async {
    var client = http.Client();

    List<ProductsModel> productsList1 =
        Provider.of<StoreNotifier>(context, listen: false).getproductsList;

    var body = "";
    try {
      var response = await client.post(Uri.parse(Apis.postorder),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return "Success";
      } else {
        var jsonString = response.body;
        return jsonString;
      }
    } catch (e) {
      return "";
    }
    return "";
  }
}

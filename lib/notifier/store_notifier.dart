import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sample_store/model/products_list_model.dart';

class StoreNotifier extends ChangeNotifier {
  StoreNotifier() {
    init().then((value) => null);
  }

  String fcmtoken = "";
  String get getFcmToken => fcmtoken;

  Future<void> init() async {
    print("object");
  }

  List<ProductsModel> productsList = [];
  List<ProductsModel> get getproductsList => productsList;

  void updateProductData(int index, ProductsModel model) {
    productsList[index] = model;
    notifyListeners();
  }

  bool isCartHaveProduct() {
    for (int i = 0; i < productsList.length; i++) {
      ProductsModel model = productsList[i];
      if (model.qty != 0) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

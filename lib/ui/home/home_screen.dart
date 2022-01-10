import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sample_store/apisutility/api_manager.dart';
import 'package:sample_store/model/products_list_model.dart';
import 'package:sample_store/model/store_detail_model.dart';
import 'package:sample_store/notifier/store_notifier.dart';
import 'package:sample_store/theme/app_theme.dart';
import 'package:sample_store/ui/ordersummary/order_summary_screen.dart';
import 'package:sample_store/ui/widget/products_list_widget.dart';
import 'package:sample_store/ui/widget/no_data_found.dart';
import 'package:sample_store/ui/widget/rating_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StoreDetailModel? storeModel;
  List<ProductsModel> productsList = [];
  bool isDataLoading = true;
  bool isNoData = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      isDataLoading = true;
    });

    APIManager().getStoreDetailApi().then((value) {
      if (value != null) {
        setState(() {
          isDataLoading = false;
          isNoData = false;
          storeModel = value;
          getProducts();
        });

        print(value);
      } else {
        setState(() {
          isDataLoading = false;
          isNoData = true;
        });

        print("no data");
      }
    });
  }

  void getProducts() {
    APIManager().getProductsApi().then((value) {
      if (value != null) {
        setState(() {
          isDataLoading = false;
          isNoData = false;
          productsList = value;
        });

        print(value);
      } else {
        setState(() {
          isDataLoading = false;
          isNoData = true;
        });

        print("no data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<StoreNotifier>(context, listen: false).productsList =
        productsList;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: MyTheme.primaryColor,
        shadowColor: Colors.white38,
        elevation: 15,
        title: "Store Detail"
            .text
            .bold
            .textStyle(TextStyle(color: MyTheme.primaryColor))
            .make(),
      ),
      body: isDataLoading && storeModel == null
          ? const CircularProgressIndicator().centered()
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    storeDetail(),
                    Consumer<StoreNotifier>(
                      builder: (context, value, child) {
                        return Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: isDataLoading &&
                                    value.getproductsList.length == 0
                                ? const CircularProgressIndicator()
                                : !isDataLoading && isNoData
                                    ? noDataFoundWidget(context)
                                    : ProductListWidget(
                                        productList: value.productsList,
                                        isScrollable: false,
                                        size: size,
                                        isfromOrderSumm: false,
                                      ),
                          ),
                        );
                      },
                    ),
                    if (productsList.length != 0)
                      ElevatedButton(
                        onPressed: () {
                          if (Provider.of<StoreNotifier>(context, listen: false)
                              .isCartHaveProduct()) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: OrderSummaryScreen(),
                              ),
                            );
                          } else {
                            VxToast.show(context,
                                msg: "Please add at least one product");
                          }
                        },
                        child: "Order Summary".text.make(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              MyTheme.darkBlusishColor),
                        ),
                      ).wh(MediaQuery.of(context).size.width / 1.2, 50),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget storeDetail() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            storeModel!.name.text
                .textStyle(TextStyle(
                    color: MyTheme.primaryColor, fontSize: 20, height: 1.3))
                .bold
                .make(),
            StarRating(
              onRatingChanged: (rating) {},
              color: MyTheme.primaryColor,
              rating: storeModel!.rating,
              starCount: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      "Opening Time".text.lg.bold.make(),
                      storeModel!.openingTime.text.lg.bold.make(),
                    ],
                  ),
                ),
                Card(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      "Closing Time".text.lg.bold.make(),
                      storeModel!.openingTime.text.lg.bold.make(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

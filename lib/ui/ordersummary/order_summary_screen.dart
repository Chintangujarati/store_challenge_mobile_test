import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sample_store/apisutility/api_manager.dart';
import 'package:sample_store/model/products_list_model.dart';
import 'package:sample_store/notifier/store_notifier.dart';
import 'package:sample_store/theme/app_theme.dart';
import 'package:sample_store/ui/success/order_success_screen.dart';
import 'package:sample_store/ui/widget/products_list_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));
  List<ProductsModel> productsList1 = [];
  int totalPrice = 0;
  final addressController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<ProductsModel> productsList =
        Provider.of<StoreNotifier>(context, listen: false).getproductsList;

    for (int i = 0; i < productsList.length; i++) {
      ProductsModel model = productsList[i];
      if (model.qty != 0) {
        productsList1.add(model);
        totalPrice = totalPrice + model.price;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Order Summary".text.make(),
        backgroundColor: Colors.white,
        foregroundColor: MyTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                ProductListWidget(
                  isfromOrderSumm: true,
                  productList: productsList1,
                  isScrollable: false,
                  size: MediaQuery.of(context).size,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price".text.xl.make(),
                    "\$${totalPrice}".text.xl.bold.make()
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Enter Delivery Address",
                    hintText: "Enter Delivery Address",
                    border: border,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Delivery Adderess.";
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      VxToast.showLoading(context, msg: "Please wait").call();
                      APIManager()
                          .postOrderApi(
                              context, addressController.text.toString())
                          .then((value) {
                        VxToast.show(context,
                            msg: "Order Successfully placed.");
                        Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                                child: OrderSuccessScreen(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 0)),
                            (route) => false);
                      });
                    }
                  },
                  child: "Submit".text.make(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.darkBlusishColor),
                  ),
                ).wh(MediaQuery.of(context).size.width, 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

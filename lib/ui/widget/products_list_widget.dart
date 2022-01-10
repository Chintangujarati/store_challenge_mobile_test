import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:sample_store/model/products_list_model.dart';
import 'package:sample_store/notifier/store_notifier.dart';
import 'package:sample_store/theme/app_theme.dart';
import 'package:sample_store/ui/widget/quntity_button_widget.dart';

class ProductListWidget extends StatefulWidget {
  final List<ProductsModel> productList;
  final bool isScrollable;
  final Size size;
  final bool isfromOrderSumm;
  const ProductListWidget({
    Key? key,
    required this.productList,
    required this.isScrollable,
    required this.size,
    this.isfromOrderSumm = false,
  }) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ProductsModel churchDataItem = widget.productList[index];
            return ProductItemWidget(
              productDataItem: churchDataItem,
              size: widget.size,
              index: index,
              isfromOrderSumm: widget.isfromOrderSumm,
            );
          },
          // set count of array list
          itemCount: widget.productList.length,
        ),
      ),
    ).centered();
  }
}

class ProductItemWidget extends StatefulWidget {
  final ProductsModel productDataItem;
  final int index;
  final Size size;
  final bool isfromOrderSumm;
  const ProductItemWidget({
    Key? key,
    required this.productDataItem,
    required this.index,
    required this.size,
    this.isfromOrderSumm = false,
  }) : super(key: key);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: GestureDetector(
      onTap: () {
        setState(() {
          if (!widget.isfromOrderSumm) {
            widget.productDataItem.isSelected =
                !widget.productDataItem.isSelected! ? true : false;

            Provider.of<StoreNotifier>(context, listen: false)
                .updateProductData(widget.index, widget.productDataItem);
          }
        });
      },
      child: Container(
        child: Row(
          children: [
            Card(
              elevation: 4,
              child: Image.network(
                widget.productDataItem.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
                  .scale(scaleValue: 1.2)
                  .box
                  .rounded
                  .p16
                  .color(MyTheme.creamColor)
                  .make(),
            ).p16().w40(context),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.productDataItem.name.text.lg.bold
                    .color(Colors.black)
                    .make(),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: Vx.mOnly(right: 16),
                  children: [
                    "\$${widget.productDataItem.price}"
                        .text
                        .bold
                        .lg
                        .color(Colors.black)
                        .make(),
                    if (widget.isfromOrderSumm)
                      "Qty : ${widget.productDataItem.qty}"
                          .text
                          .lg
                          .color(Colors.black)
                          .make()
                          .p16(),
                    if (!widget.isfromOrderSumm)
                      widget.productDataItem.qty != 0
                          ? QuantityButton(
                              initialQuantity: widget.productDataItem.qty!,
                              onQuantityChange: (p0) {
                                setState(() {
                                  widget.productDataItem.qty = p0;
                                  Provider.of<StoreNotifier>(context,
                                          listen: false)
                                      .updateProductData(
                                          widget.index, widget.productDataItem);
                                });
                              },
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.productDataItem.qty = 1;
                                  Provider.of<StoreNotifier>(context,
                                          listen: false)
                                      .updateProductData(
                                          widget.index, widget.productDataItem);
                                });
                              },
                              child: "Add to cart".text.make(),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      MyTheme.darkBlusishColor),
                                  shape: MaterialStateProperty.all(
                                      const StadiumBorder())),
                            ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    ))
        .color(widget.productDataItem.isSelected!
            ? MyTheme.primaryColor
            : Colors.white)
        .roundedSM
        .shadowMd
        .outerShadowMd
        .square(150)
        .make()
        .py16();
  }
}

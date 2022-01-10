import 'package:flutter/material.dart';
import 'package:sample_store/theme/app_theme.dart';
import 'package:velocity_x/velocity_x.dart';

Widget noDataFoundWidget(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        "No Data Found"
            .text
            .bold
            .xl2
            .textStyle(TextStyle(color: MyTheme.primaryColor))
            .make()
      ],
    ),
  ).centered();
}

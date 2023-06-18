import 'package:flutter/widgets.dart';
import "package:project_nova/consts/consts.dart";

Widget OrderPlaceDetails(data) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [
          "Order Code".text.fontFamily(semibold).make(),
          "${data['order_code']}".text.fontFamily(semibold).make()
        ],
      ),
      Column(
        children: [
          "Order Code".text.fontFamily(semibold).make(),
          "${data['order_code']}".text.fontFamily(semibold).make()
        ],
      )
    ]),
  );
}

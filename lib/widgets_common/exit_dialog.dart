import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          "Confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
          const Divider(),
          10.heightBox,
          "Are you sure you want to exit?"
              .text
              .color(darkFontGrey)
              .size(16)
              .make(),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                  color: fontGrey,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  textColor: whiteColor,
                  title: "No"),
              ourButton(
                  color: Colors.black,
                  onPress: () {
                    SystemNavigator.pop();
                  },
                  textColor: whiteColor,
                  title: "Yes"),
            ],
          )
        ],
      )
          .box
          .color(lightGrey)
          .padding(const EdgeInsets.all(12))
          .roundedSM
          .make());
}

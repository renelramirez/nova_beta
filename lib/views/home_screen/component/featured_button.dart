import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/views/category_screen/category_details.dart';

Widget featuredButton({
  String? title,
}) {
  return Row(
    children: [
      // Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .outerShadowMd
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}

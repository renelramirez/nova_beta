import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
// ignore: unused_import
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/product_controller.dart';
import 'package:project_nova/widgets_common/our_button.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetail({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                      controller.isFav(false);
                    } else {
                      controller.addToWishlist(data.id, context);
                      controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? Colors.black : fontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                            autoPlay: true,
                            height: 400,
                            aspectRatio: 2 / 1,
                            viewportFraction: 1.0,
                            itemCount: data['p_imgs'].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data["p_imgs"][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            })
                        .box
                        .topRounded()
                        .outerShadowXl
                        .clip(Clip.antiAlias)
                        .make(),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 500,
                                child: title!.text
                                    .size(18)
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              VxRating(
                                isSelectable: false,
                                value: double.parse(data['p_rating']),
                                onRatingUpdate: (value) {},
                                normalColor: textfieldGrey,
                                selectionColor: golden,
                                count: 5,
                                maxRating: 5,
                                size: 25,
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "GHS ${data['p_price']}"
                                    .text
                                    .black
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.heightBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child:
                                      "Total".text.color(textfieldGrey).make()),
                              "      GHS ${controller.totalPrice.value}"
                                  .text
                                  .color(Colors.black)
                                  .size(16)
                                  .fontFamily(bold)
                                  .makeCentered()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Description"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 500,
                                child: "${data['p_desc']}"
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.bottomRounded().white.shadowSm.make(),
                    ),
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                  color: Colors.black,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          color: data['p_colors'][controller.colorIndex.value],
                          context: context,
                          vendorID: data['vendor_id'],
                          img: data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to Cart");
                    } else {
                      VxToast.show(context,
                          msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to Cart",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

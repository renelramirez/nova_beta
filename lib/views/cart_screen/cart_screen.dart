import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/controllers/cart_controller.dart';
import 'package:project_nova/services/firestore_servies.dart';
import 'package:project_nova/views/cart_screen/shipping_screen.dart';
import 'package:project_nova/widgets_common/loading_indicator.dart';
import 'package:project_nova/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ourButton(
          color: Colors.black,
          onPress: () {
            Get.to(() => const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to shipping",
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.fontFamily(bold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.size(24).color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                "${data[index]['img']}",
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              title:
                                  "${data[index]['title']} (x${data[index]['qty']})"
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                              subtitle: "GHS ${data[index]['tprice']}"
                                  .text
                                  .black
                                  .fontFamily(bold)
                                  .make(),
                              trailing:
                                  const Icon(Icons.delete, color: Colors.black)
                                      .onTap(() {
                                FirestoreServices.deleteDocument(
                                    data[index].id);
                              }),
                            );
                          }).box.white.rounded.outerShadowMd.make()),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Sub total"
                          .text
                          .fontFamily(semibold)
                          .color(Colors.black)
                          .make(),
                      Obx(
                        () => "GHS ${controller.totalIP}"
                            .text
                            .fontFamily(bold)
                            .color(Colors.black)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .topRounded()
                      .width(context.screenWidth - 60)
                      .make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Delivery fee"
                          .text
                          .fontFamily(semibold)
                          .color(Colors.black)
                          .make(),
                      "GHS 0".text.fontFamily(bold).color(Colors.black).make(),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .width(context.screenWidth - 60)
                      .make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total "
                          .text
                          .fontFamily(semibold)
                          .color(Colors.black)
                          .make(),
                      Obx(
                        () => "${controller.totalIP}"
                            .numCurrency
                            .text
                            .fontFamily(bold)
                            .color(Colors.black)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .bottomRounded()
                      .width(context.screenWidth - 60)
                      .make(),
                  10.heightBox,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

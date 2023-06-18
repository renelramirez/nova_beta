import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/cart_controller.dart';
import 'package:project_nova/widgets_common/our_button.dart';

import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/loading_indicator.dart';
import '../home_screen/home.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod: controller.paymentIndex.value,
                        totalAmount: controller.totalIP.value);

                    await controller.clearCart();
                    VxToast.show(context,
                        msg: "Ordered placed successfully",
                        position: VxToastPosition.top);
                    Get.offAll(const Home());
                  },
                  color: Colors.black,
                  textColor: whiteColor,
                  title: "Place my order"),
        ),
      ),
      body: Column(
        children: [
          10.heightBox,
          "Choose payment method".text.fontFamily(bold).size(20).make(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  children: List.generate(
                    1,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Stack(
                              children: [
                                Image.asset(
                                  imgCod,
                                  width: 240,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                controller.paymentIndex.value == index
                                    ? Transform.scale(
                                        scale: 1,
                                        child: Checkbox(
                                            activeColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            value: true,
                                            onChanged: (value) {}),
                                      )
                                    : Container(),
                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: "Cash on Delivery"
                                        .text
                                        .white
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
          10.heightBox,
          "Enter Address details".text.fontFamily(bold).size(20).make(),
          10.heightBox,
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  customTextField(
                      hint: "Address",
                      isPass: false,
                      title: "Address",
                      controller: controller.addressController),
                  customTextField(
                      hint: "City",
                      isPass: false,
                      title: "city",
                      controller: controller.cityController),
                  customTextField(
                      hint: "state",
                      isPass: false,
                      title: "State",
                      controller: controller.stateController),
                  customTextField(
                      hint: "Postal code",
                      isPass: false,
                      title: "Postal code",
                      controller: controller.postalcodeController),
                  customTextField(
                      hint: "Phone",
                      isPass: false,
                      title: "Phone",
                      controller: controller.phoneController),
                ],
              )
                  .box
                  .roundedLg
                  .white
                  .outerShadowMd
                  .padding(const EdgeInsets.all(12))
                  .make())
        ],
      ),
    );
  }
}

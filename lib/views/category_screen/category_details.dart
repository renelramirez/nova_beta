import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/controllers/product_controller.dart';
import 'package:project_nova/views/category_screen/item_detail.dart';

import '../../services/firestore_servies.dart';
import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).black.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 8),
                child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                              .text
                              .size(16)
                              .fontFamily(semibold)
                              .color(whiteColor)
                              .makeCentered()
                              .box
                              .black
                              .roundedLg
                              .size(130, 30)
                              .padding(const EdgeInsets.all(4))
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .make()
                              .onTap(() {
                            switchCategory("${controller.subcat[index]}");
                            setState(() {});
                          })),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: loadingIndicator(),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: "No products found!"
                          .text
                          .color(darkFontGrey)
                          .makeCentered(),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 180,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ).box.roundedSM.clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .black
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    10.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .outerShadowSm
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  controller.checkifFav(data[index]);
                                  Get.to(() => ItemDetail(
                                      title: "${data[index]['p_name']}",
                                      data: data[index]));
                                }),
                              );
                            }));
                  }
                }),
          ],
        ));
  }
}

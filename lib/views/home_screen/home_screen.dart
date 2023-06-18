import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/home_controllers.dart';
import 'package:project_nova/services/firestore_servies.dart';
import 'package:project_nova/views/category_screen/item_detail.dart';
import 'package:project_nova/views/home_screen/search_screen.dart';
import 'package:project_nova/widgets_common/home_buttons.dart';
import 'package:project_nova/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  icAppLogo,
                  fit: BoxFit.cover,
                  height: 35,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: appname.text.black.fontFamily(bold).size(22).make(),
                )
              ],
            ),
          )),
      body: Container(
        padding: const EdgeInsets.all(0),
        color: whiteColor,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18), color: lightGrey),
                alignment: Alignment.centerRight,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      focusColor: fontGrey,
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: darkFontGrey,
                      ).onTap(() {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScreen(
                                title: controller.searchController.text,
                              ));
                        }
                      }),
                      filled: true,
                      fillColor: lightGrey,
                      hintText: searchHint,
                      hintStyle: const TextStyle(color: darkFontGrey),
                    ),
                  ),
                ),
              ),
            ),
            20.heightBox,
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ["Special offers".text.bold.size(20).make()],
                  ),
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: "See all"
                                .text
                                .bold
                                .size(18)
                                .color(darkFontGrey)
                                .make())
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.heightBox,
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 10,
                      viewportFraction: 0.9,
                      autoPlay: true,
                      height: 180,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .outerShadowMd
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.12,
                              width: context.screenWidth / 4,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategory
                                  : index == 1
                                      ? brand
                                      : topSellers,
                            )),
                  ),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featureProduct.text.white
                              .fontFamily(bold)
                              .size(20)
                              .makeCentered(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getfeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No featured products"
                                        .text
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    featuredData[index]
                                                        ['p_imgs'][0],
                                                    width: 150,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  )
                                                      .box
                                                      .rounded
                                                      .clip(Clip.antiAlias)
                                                      .make(),
                                                  10.heightBox,
                                                  SizedBox(
                                                    width: 200,
                                                    child:
                                                        "${featuredData[index]['p_name']}"
                                                            .text
                                                            .fontFamily(bold)
                                                            .size(18)
                                                            .color(darkFontGrey)
                                                            .makeCentered(),
                                                  ),
                                                  10.heightBox,
                                                  Column(
                                                    children: [
                                                      "GHS ${featuredData[index]['p_price']}"
                                                          .text
                                                          .black
                                                          .fontFamily(bold)
                                                          .size(16)
                                                          .make(),
                                                    ],
                                                  ),
                                                ],
                                              )
                                                  .box
                                                  .white
                                                  .rounded
                                                  .margin(const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16))
                                                  .padding(
                                                      const EdgeInsets.all(5))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(() => ItemDetail(
                                                      title:
                                                          "${featuredData[index]['p_name']}",
                                                      data: featuredData[index],
                                                    ));
                                              })),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 10.heightBox,
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: featuredCategories.text
                  //         .color(darkFontGrey)
                  //         .size(22)
                  //         .fontFamily(bold)
                  //         .make(),
                  //   ),
                  // ),
                  10.heightBox,
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: List.generate(
                  //         3,
                  //         (index) => Column(
                  //           children: [
                  //             featuredButton(
                  //               // icon: featureImage1[index],
                  //               title: featuredTitle1[index],
                  //             ),
                  //             10.heightBox,
                  //             featuredButton(
                  //               // icon: featureImage2[index],
                  //               title: featuredTitle2[index],
                  //             ),
                  //           ],
                  //         ),
                  //       ).toList(),
                  //     ),
                  //   ),
                  // ),
                  20.heightBox,
                  Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: allproducts.text
                              .fontFamily(bold)
                              .color(whiteColor)
                              .size(22)
                              .make()),
                    ),
                  ),
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 320),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      width: 180,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ).box.rounded.clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(bold)
                                        .size(20)
                                        .black
                                        .make(),
                                    10.heightBox,
                                    "GHS ${allproductsdata[index]['p_price']}"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .outerShadowMd
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetail(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      })
                ],
              ),
            )),
          ],
        )),
      ),
    );
  }
}

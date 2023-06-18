import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/product_controller.dart';
import 'package:project_nova/views/category_screen/category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: categories.text.fontFamily(semibold).size(24).black.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 7,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 110),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      40.heightBox,
                      Column(
                        children: [
                          categoriesList[index]
                              .text
                              .color(Colors.white)
                              .semiBold
                              .size(28)
                              .makeCentered(),
                        ],
                      ),
                      // Image.asset(
                      //   categoryImages[index],
                      //   width: 180,
                      //   height: 140,
                      //   fit: BoxFit.cover,
                      // ).box.clip(Clip.antiAlias).rounded.make(),
                    ],
                  ),
                ],
              )
                  .box
                  .black
                  .rounded
                  .size(context.screenWidth - 20, 500)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(() => CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    );
  }
}

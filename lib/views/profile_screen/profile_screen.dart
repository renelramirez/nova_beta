import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/auth_controller.dart';
import 'package:project_nova/controllers/profile_controller.dart';
import 'package:project_nova/services/firestore_servies.dart';
import 'package:project_nova/views/auth_screen/login_screen.dart';
import 'package:project_nova/views/orders_screen/orders_screen.dart';
import 'package:project_nova/views/profile_screen/edit_profile_screen.dart';
import 'package:project_nova/views/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ));
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    )).onTap(() {
                  controller.nameController.text = data['name'];

                  Get.to(() => EditProfileScreen(data: data));
                }),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      // data['imageUrl'] == ''
                      //     ? Image.asset(imgProfile2,
                      //             width: 100, fit: BoxFit.cover)
                      //         .box
                      //         .roundedFull
                      //         .clip(Clip.antiAlias)
                      //         .makeCentered()
                      //     : Image.network(data['imageUrl'],
                      //             width: 100, fit: BoxFit.cover)
                      //         .box
                      //         .roundedFull
                      //         .clip(Clip.antiAlias)
                      //         .make(),
                      50.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "${data['name']}"
                              .text
                              .size(20)
                              .bold
                              .fontFamily(semibold)
                              .black
                              .make(),
                          "${data['email']}".text.black.size(16).make(),
                        ],
                      )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                          color: whiteColor,
                        )),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signoutMethod(context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: "Logout".text.fontFamily(semibold).black.make(),
                      ),
                    ],
                  ),
                ),
              ),
              50.heightBox,

              // FutureBuilder(
              //   future: FirestoreServices.getCount(),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (snapshot.hasData) {
              //       return Center(child: loadingIndicator());
              //     } else {
              //       var countData = snapshot.data;

              //       return Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           detailsCard(
              //               count: countData[0],
              //               title: "in your cart",
              //               width: context.screenWidth / 3.5),
              //           detailsCard(
              //               count: countData[1],
              //               title: "in your cart",
              //               width: context.screenWidth / 3.5),
              //           detailsCard(
              //               count: countData[2],
              //               title: "in your cart",
              //               width: context.screenWidth / 3.5)
              //         ],
              //       );
              //     }
              //   },
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // detailsCard(
                  //   context.screenWidth / 3.5,
                  //   data['cart_count'],
                  //   "in your cart",
                  // ),
                  // detailsCard(
                  //   context.screenWidth / 3.5,
                  //   data['wishlist_count'],
                  //   "in your wishlist",
                  // ),
                  // detailsCard(context.screenWidth / 3.5, data['order_count'],
                  //     "your orders"),
                ],
              ),
              ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrderScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonsIcon[index],
                            width: 22,
                          ),
                          title: profileButtonsList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      })
                  .box
                  .white
                  .rounded
                  .margin(const EdgeInsets.all(12))
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .shadowSm
                  .make(),

              const Spacer(),

              "Note".text.black.bold.size(18).makeCentered(),
              5.heightBox,
              "Nova is beta and most features\nare undergoing various testing before implementation\nto provide you the best services only\n Implementation will be in the next update\nPlease email any suggestions or complaint to \ntheberriesproject.nova@gmail.com"
                  .text
                  .color(Colors.grey)
                  .fontFamily(regular)
                  .size(10)
                  .makeCentered(),
              10.heightBox,
            ]));
          }
        },
      ),
    );
  }
}

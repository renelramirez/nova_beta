import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/services/firestore_servies.dart';
import 'package:project_nova/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My Wishlist "
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlist(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No items yet!"
                    .text
                    .size(24)
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['p_imgs'][0]}",
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                title: "${data[index]['p_name']}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                                subtitle: "GHS ${data[index]['p_price']}"
                                    .text
                                    .black
                                    .size(18)
                                    .fontFamily(bold)
                                    .make(),
                                trailing: const Icon(Icons.favorite,
                                        color: Colors.black)
                                    .onTap(() async {
                                  await firestore
                                      .collection(productCollection)
                                      .doc(data[index].id)
                                      .set({
                                    'p_wishlist': FieldValue.arrayRemove(
                                        [currentUser!.uid])
                                  }, SetOptions(merge: true));
                                }),
                              )
                                  .box
                                  .rounded
                                  .outerShadow
                                  .white
                                  .margin(const EdgeInsets.all(4))
                                  .padding(const EdgeInsets.all(8))
                                  .make();
                            }),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}

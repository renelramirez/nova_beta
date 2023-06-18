import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/services/firestore_servies.dart';
import 'package:project_nova/widgets_common/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title:
              "My Orders ".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No orders yet!".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: "${index + 1}"
                              .text
                              .fontFamily(bold)
                              .color(lightGrey)
                              .xl
                              .make(),
                          title: data[index]['order_code']
                              .toString()
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          subtitle: data[index]['total_amount']
                              .toString()
                              .numCurrency
                              .text
                              .fontFamily(bold)
                              .make(),
                        )
                            .box
                            .rounded
                            .outerShadow
                            .white
                            .margin(const EdgeInsets.all(4))
                            .padding(const EdgeInsets.all(8))
                            .make();
                      }),
                );
              }
            }));
  }
}

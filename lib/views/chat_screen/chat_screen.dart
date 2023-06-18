// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/controllers/chat_controller.dart';
import 'package:project_nova/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                senderBubble(),
                senderBubble(),
              ],
            )),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    hintText: "Type a message....",
                  ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send, color: redColor)),
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}

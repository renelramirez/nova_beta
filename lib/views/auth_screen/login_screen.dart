import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/consts/list.dart';
import 'package:project_nova/controllers/auth_controller.dart';
import 'package:project_nova/views/auth_screen/signup_screen.dart';
import 'package:project_nova/views/home_screen/home.dart';
import 'package:project_nova/widgets_common/custom_textfield.dart';
import 'package:project_nova/widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                icAppLogo,
                width: 80,
              ),
              20.heightBox,
              "Log in to $appname".text.fontFamily(bold).black.size(20).make(),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailControler),
                    10.heightBox,
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordControler),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: forgetpass.text.color(darkFontGrey).make())),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          )
                        : ourButton(
                            color: Colors.black,
                            title: login,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isloading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            },
                          )
                            .box
                            .width(context.screenWidth - 50)
                            .height(50)
                            .make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                            color: fontGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () {
                              Get.to(() => const SignupScreen());
                            })
                        .box
                        .width(context.screenWidth - 50)
                        .height(50)
                        .make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 20,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  ),
                                ),
                              )),
                    )
                  ],
                )
                    .box
                    .white
                    .roundedLg
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowMd
                    .make(),
              ),
              const Spacer(),
              credits.text.black.fontFamily(semibold).size(18).make(),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

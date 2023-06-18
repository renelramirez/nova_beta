import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/controllers/auth_controller.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/views/home_screen/home.dart';

import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              10.heightBox,
              "Let's Sign up on $appname"
                  .text
                  .fontFamily(bold)
                  .black
                  .size(18)
                  .make(),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPass: false),
                    10.heightBox,
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        isPass: false),
                    10.heightBox,
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        isPass: true),
                    10.heightBox,
                    customTextField(
                        hint: retypePassHint,
                        title: retypePassword,
                        controller: passwordRetypeController,
                        isPass: true),
                    15.heightBox,
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: Colors.black,
                                  )),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: Colors.black,
                                  )),
                            ],
                          )),
                        ),
                      ],
                    ),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black))
                        : ourButton(
                            color: isCheck == true ? Colors.black : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  )
                                      .then((value) {
                                    return controller.storeUserData(
                                      name: nameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                }
                              }
                            },
                          )
                            .box
                            .width(context.screenWidth - 50)
                            .height(50)
                            .make(),
                    10.heightBox,
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: Colors.black,
                          ),
                        )
                      ]),
                    ).onTap(() {
                      Get.back();
                    }),
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

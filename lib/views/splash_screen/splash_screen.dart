import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/views/auth_screen/login_screen.dart';
import 'package:project_nova/views/home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 120)),
            20.heightBox,
            Image.asset(
              icAppLogo,
              width: 100,
            ),
            10.heightBox,
            appname.text.fontFamily(bold).size(28).black.make(),
            10.heightBox,
            appversion.text.color(darkFontGrey).make(),
            const Spacer(),
            credits.text.black.fontFamily(semibold).size(18).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';
import 'package:project_nova/controllers/home_controllers.dart';
import 'package:project_nova/views/cart_screen/cart_screen.dart';
import 'package:project_nova/views/category_screen/category_screen.dart';
import 'package:project_nova/views/home_screen/home_screen.dart';
import 'package:project_nova/views/profile_screen/profile_screen.dart';
import 'package:project_nova/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 30), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 30), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 30), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 30), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx((() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              elevation: 0,
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: Colors.black,
              selectedLabelStyle: const TextStyle(fontFamily: bold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              }),
        ),
      ),
    );
  }
}

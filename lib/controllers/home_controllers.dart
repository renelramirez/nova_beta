import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_nova/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var featuredList = [];
  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}

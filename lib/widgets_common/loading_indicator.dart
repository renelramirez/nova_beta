import 'package:flutter/material.dart';
import 'package:project_nova/consts/consts.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.black),
  );
}

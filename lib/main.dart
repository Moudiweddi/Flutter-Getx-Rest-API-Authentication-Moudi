import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_registration/screens/auth/auth_screen.dart';
import 'package:login_registration/screens/home.dart';

main() async {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthScreen(),
  ));
}

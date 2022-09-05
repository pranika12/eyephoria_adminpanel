import 'package:admin_panel_pranika_fyp/pages/home_page.dart';
import 'package:admin_panel_pranika_fyp/pages/loader.dart';
import 'package:admin_panel_pranika_fyp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/authentication_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Authentication());

  runApp(const MaterialApp(
      home: GetMaterialApp(
    title: "Admin Panel",
    home: Loader(),
  )));
}

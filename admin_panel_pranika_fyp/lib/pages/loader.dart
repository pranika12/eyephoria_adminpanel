import 'package:admin_panel_pranika_fyp/pages/home_page.dart';
import 'package:admin_panel_pranika_fyp/pages/login_page.dart';
import 'package:admin_panel_pranika_fyp/utils/shared_preds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkifAUthenticated();
  }

  checkifAUthenticated() async {
    var token = await authService.getToken();
    if (token != null) {
      Get.offAll(const MyHomePage());
    } else {
      Get.offAll(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: 200,
            ),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

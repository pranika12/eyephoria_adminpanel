import 'dart:convert';

import 'package:admin_panel_pranika_fyp/utils/api.dart';
import 'package:admin_panel_pranika_fyp/utils/constants.dart';
import 'package:admin_panel_pranika_fyp/utils/shared_preds.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategroyController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();

  add(data) async {
    loading.value = true;
    data['token'] = await authService.getToken();
    var url = Uri.parse(ADD_CATEGORY_API);
    await Future.delayed(const Duration(seconds: 3));
    var response = await http.post(url, body: data);
    loading.value = false;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        Get.back();
        showMessage(message: jsonResponse["message"]);
      } else {
        showMessage(message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

import 'dart:convert';
import 'package:admin_panel_pranika_fyp/model/category.dart';
import 'package:admin_panel_pranika_fyp/utils/api.dart';
import 'package:admin_panel_pranika_fyp/utils/constants.dart';
import 'package:admin_panel_pranika_fyp/utils/shared_preds.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var loading = false.obs;
  var categories = <Category>[].obs;

  final AuthService authService = AuthService();

  //on init state
  @override
  void onInit() {
    super.onInit();
    get();
  }

  get() async {
    loading.value = true;
    var url = Uri.parse(GET_CATEGORIES_API);
    var response = await http.get(url);
    loading.value = false;
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        categories.value = (jsonResponse["data"] as List)
            .map((e) => Category.fromJson(e))
            .toList();

        print(categories.value);
        showMessage(message: jsonResponse["message"]);
      } else {
        showMessage(message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  add(data) async {
    loading.value = true;
    data['token'] = await authService.getToken();
    var url = Uri.parse(ADD_CATEGORY_API);
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

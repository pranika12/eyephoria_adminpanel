import 'dart:convert';

import 'package:admin_panel_pranika_fyp/utils/constants.dart';
import 'package:admin_panel_pranika_fyp/utils/shared_preds.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/api.dart';

class ProductController extends GetxController {
  var loading = false.obs;
  final AuthService authService = AuthService();

  add(data, PickedFile? file) async {
    loading.value = true;
    data['token'] = await authService.getToken();
    var url = Uri.parse(ADD_PRODUCT_API);
    //multipart that takes file
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(data);
    if (file != null) {
      var pic = await http.MultipartFile.fromPath('image', file.path);
      request.files.add(pic);
    }
    var response = await request.send();

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(await response.stream.bytesToString());
      if (decodedResponse['success']) {
        Get.back();
        showMessage(message: decodedResponse['message']);
      } else {
        showMessage(message: decodedResponse['message'], isSuccess: false);
      }
      loading.value = false;
    } else {
      loading.value = false;
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}

import 'package:admin_panel_pranika_fyp/components/my_button.dart';
import 'package:admin_panel_pranika_fyp/controller/authentication_controller.dart';
import 'package:admin_panel_pranika_fyp/pages/forms/add_edit_category_form.dart';
import 'package:admin_panel_pranika_fyp/pages/forms/add_edit_product_form.dart';
import 'package:admin_panel_pranika_fyp/utils/shared_preds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabOne extends StatelessWidget {
  final AuthService authService = AuthService();
  final authentication = Get.find<Authentication>();

  TabOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyButton(
                onTap: () {
                  Get.bottomSheet(AddEditCategoryForm());
                },
                text: 'Add Category'),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                onTap: () {
                  Get.to(AddEditProductForm());
                },
                text: 'Add Product'),
          ],
        ),
      ),
    );
  }
}

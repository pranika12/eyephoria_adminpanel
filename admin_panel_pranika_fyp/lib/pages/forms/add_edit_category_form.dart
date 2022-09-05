import 'package:admin_panel_pranika_fyp/components/my_button.dart';
import 'package:admin_panel_pranika_fyp/components/my_field.dart';
import 'package:admin_panel_pranika_fyp/controller/category_controller.dart';
import 'package:admin_panel_pranika_fyp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCategoryForm extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final CategroyController categoryController = Get.put(CategroyController());
  AddEditCategoryForm({Key? key, this.title = "Add Category"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 20)),
              Column(
                children: [
                  MyField(
                    text: "Category Name",
                    controller: _nameController,
                    myValidator: (value) {
                      if (value!.length < 3) {
                        return "Category name must be at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  MyField(
                    text: "Category description",
                    controller: _descriptionController,
                  ),
                ],
              ),
              Obx(() => MyButton(
                  isLoading: categoryController.loading.value,
                  onTap: () {
                    var data = {
                      'name': _nameController.text,
                      'description': _descriptionController.text
                    };
                    var isValidated = _formKey.currentState!.validate();
                    if (isValidated) {
                      categoryController.add(data);
                    }
                  },
                  text: 'Save')),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category_model.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../utils/utility_functions.dart';
import '../../../view_models/category_view_model.dart';
import '../../auth/widgets/global_textfield.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({
    super.key,
    required this.categoryName,
    required this.imageAddress,
    required this.docId,
  });

  final String categoryName;
  final String imageAddress;
  final String docId;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Edit Category',
          style: AppTextStyles.sfProRoundedSemiBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter new Category name:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.categoryName,
              iconPath: AppImages.title,
              controller: nameController,
            ),
            20.getH(),
            Text(
              'Enter new Image address:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.imageAddress,
              iconPath: AppImages.photo,
              controller: imageController,
            ),
            20.getH(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    context.read<CategoriesViewModel>().updateCategory(
                          CategoryModel(
                            imageUrl: widget.imageAddress,
                            categoryName: nameController.text,
                            docId: widget.docId,
                          ),
                          context,
                        );
                    showSnackbar(
                      context: context,
                      message: "Category Updated",
                    );
                  }
                  if (imageController.text.isNotEmpty) {
                    context.read<CategoriesViewModel>().updateCategory(
                          CategoryModel(
                            imageUrl: imageController.text,
                            categoryName: widget.categoryName,
                            docId: widget.docId,
                          ),
                          context,
                        );
                    showSnackbar(
                      context: context,
                      message: "Category Updated",
                    );
                  }
                  if (nameController.text.isEmpty &&
                      imageController.text.isEmpty) {
                    showSnackbar(
                      context: context,
                      message: "Enter Category name and image address!",
                    );
                  }
                },
                child: Text(
                  'SUBMIT',
                  style: AppTextStyles.sfProRoundedSemiBold
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            10.getH(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  context
                      .read<CategoriesViewModel>()
                      .deleteCategory(widget.docId, context);
                  Navigator.pop(context);
                },
                child: Text(
                  'DELETE',
                  style: AppTextStyles.sfProRoundedSemiBold
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

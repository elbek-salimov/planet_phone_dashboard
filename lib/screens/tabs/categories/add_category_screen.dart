import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_model.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../utils/utility_functions.dart';
import '../../../view_models/category_view_model.dart';
import '../../auth/widgets/global_textfield.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
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
          'Add Category',
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
              'Enter Category name:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: 'Name',
              iconPath: AppImages.title,
              controller: nameController,
            ),
            20.getH(),
            Text(
              'Enter Image address:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: 'Image link',
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
                  if (nameController.text.isNotEmpty &&
                      imageController.text.isNotEmpty) {
                    context.read<CategoriesViewModel>().insertCategory(
                          CategoryModel(
                            imageUrl: imageController.text,
                            categoryName: nameController.text,
                            docId: "",
                          ),
                          context,
                        );
                    showSnackbar(
                      context: context,
                      message: "Category Saved",
                    );
                  } else {
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
            )
          ],
        ),
      ),
    );
  }
}

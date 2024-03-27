import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/product_model.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../utils/utility_functions.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/product_view_model.dart';
import '../../auth/widgets/global_textfield.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.imageAddress,
    required this.docId,
    required this.categoryName,
  });

  final String productName;
  final double productPrice;
  final String productDescription;
  final String imageAddress;
  final String docId;
  final String categoryName;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String? dropdownValue;

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Edit Product',
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
              'Edit Product name:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.productName,
              iconPath: AppImages.title,
              controller: nameController,
            ),
            20.getH(),
            Text(
              'Edit Product price:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.productPrice.toString(),
              iconPath: AppImages.price,
              controller: priceController,
            ),
            20.getH(),
            Text(
              'Edit Product description:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.productDescription,
              iconPath: AppImages.description,
              controller: descriptionController,
            ),
            20.getH(),
            Text(
              'Edit Image address:',
              style: AppTextStyles.sfProRoundedLight.copyWith(fontSize: 16),
            ),
            10.getH(),
            GlobalTextField(
              title: widget.imageAddress,
              iconPath: AppImages.photo,
              controller: imageController,
            ),
            20.getH(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3.30,
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 3.30),
                    )
                  ]),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.w),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                hint: Text(widget.categoryName),
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: context
                    .read<CategoriesViewModel>()
                    .categories
                    .map((category) {
                  return DropdownMenuItem<String>(
                    value: category.docId,
                    child: Text(category.categoryName),
                  );
                }).toList(),
              ),
            ),
            10.getH(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (nameController.text.isNotEmpty ||
                      priceController.text.isNotEmpty ||
                      descriptionController.text.isNotEmpty ||
                      imageController.text.isNotEmpty ||
                      dropdownValue != null) {
                    context.read<ProductViewModel>().updateProduct(
                          ProductModel(
                            imageUrl: imageController.text.isNotEmpty ? imageController.text : widget.imageAddress,
                            docId: widget.docId,
                            price: priceController.text.isNotEmpty ? double.parse(priceController.text) : widget.productPrice,
                            productName: nameController.text.isNotEmpty ? nameController.text : widget.productName,
                            productDescription: descriptionController.text.isNotEmpty ? descriptionController.text : widget.productDescription,
                            categoryId: dropdownValue != null ? dropdownValue! : widget.categoryName,
                          ),
                          context,
                        );
                    showSnackbar(
                      context: context,
                      message: "Product Updated",
                    );
                  } else {
                    showSnackbar(
                      context: context,
                      message: "Edit  product some field!",
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
                      .read<ProductViewModel>()
                      .deleteProduct(widget.docId, context);
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

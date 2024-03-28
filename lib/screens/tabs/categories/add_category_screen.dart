import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_model.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../utils/utility_functions.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/image_view_model.dart';
import '../../auth/widgets/global_textfield.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String storagePath = '';
  String imageUrl = '';
  final ImagePicker picker = ImagePicker();

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
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                takePhoto();
              },
              child: Ink(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.30,
                        color: Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 3.30),
                      )
                    ]),
                child: const Center(
                  child: Text(
                    'Image',
                    style: AppTextStyles.sfProRoundedRegular,
                  ),
                ),
              ),
            ),
            20.getH(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                    debugPrint("IMAGE URL: $imageUrl");
                  if (nameController.text.isNotEmpty && imageUrl.isNotEmpty) {
                    context.read<CategoriesViewModel>().insertCategory(
                          CategoryModel(
                            imageUrl: imageUrl,
                            categoryName: nameController.text,
                            docId: "",
                            storagePath: storagePath,
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


  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/category_images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/category_images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }



  takePhoto(){
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _getImageFromCamera();
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
                    Text(
                      'Camera',
                      style: AppTextStyles.sfProRoundedSemiBold
                          .copyWith(fontSize: 14),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _getImageFromGallery();
                      },
                      icon: const Icon(Icons.photo),
                    ),
                    Text(
                      'Gallery',
                      style: AppTextStyles.sfProRoundedSemiBold
                          .copyWith(fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

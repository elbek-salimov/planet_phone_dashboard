import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category_model.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../view_models/category_view_model.dart';
import '../../routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Categories', style: AppTextStyles.sfProRoundedSemiBold),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: width - 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.addCategory);
                },
                child: const Text('Add Category'),
              ),
            ),
          ),
          10.getH(),
          StreamBuilder<List<CategoryModel>>(
            stream: context.read<CategoriesViewModel>().listenCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                List<CategoryModel> list = snapshot.data as List<CategoryModel>;
                return Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(
                          list.length,
                          (index) {
                            CategoryModel category = list[index];
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.h, left: 20.w, right: 20.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5))
                                  ]),
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                    top: 5.h, bottom: 5.h, left: 5.w),
                                leading: SizedBox(
                                  width: 50.w,
                                  child: Image.network(category.imageUrl),
                                ),
                                title: Text(category.categoryName),
                                trailing: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    splashRadius: 22,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.editCategory,
                                        arguments: {
                                          'categoryName': category.categoryName,
                                          'imageAddress': category.imageUrl,
                                          'docId': category.docId,
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

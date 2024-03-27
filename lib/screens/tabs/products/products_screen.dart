import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/product_view_model.dart';
import '../../routes.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategoryId = '';

  @override
  void initState() {
    selectedCategoryId =
        context.read<CategoriesViewModel>().categories[0].docId;
    super.initState();
  }

  int selectedIndex = 0;
  String selectedCategoryName = '';

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: AppTextStyles.sfProRoundedSemiBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width - 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addProduct);
              },
              child: const Text('Add Product'),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                10.getW(),
                ...List.generate(
                    context.read<CategoriesViewModel>().categories.length,
                    (index) {
                  CategoryModel categories =
                      context.read<CategoriesViewModel>().categories[index];
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2.w,
                          color: selectedIndex == index
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                          selectedCategoryName = categories.categoryName;
                          selectedCategoryId = categories.docId;
                          context
                              .read<ProductViewModel>()
                              .getProductsByCategory(categories.docId);
                        });
                      },
                      child: Text(
                        categories.categoryName,
                        style: AppTextStyles.sfProRoundedMedium.copyWith(
                            fontSize: 18,
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          10.getH(),
          StreamBuilder<List<ProductModel>>(
            stream: context
                .read<ProductViewModel>()
                .getProducts(selectedCategoryId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                List<ProductModel> list = snapshot.data as List<ProductModel>;
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 15.w,
                    ),
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    itemCount: list.length,
                    // total number of items
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 15.w),
                              height: 130.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Image.network(list[index].imageUrl,
                                  color: Colors.grey.withOpacity(0.3),
                                  colorBlendMode: BlendMode.darken),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                splashRadius: 20.w,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.editProduct,
                                    arguments: {
                                      'productName': list[index].productName,
                                      'productPrice': list[index].price,
                                      'productDescription':
                                          list[index].productDescription,
                                      'imageAddress': list[index].imageUrl,
                                      'docId': list[index].docId,
                                      'categoryName': selectedCategoryName,
                                    },
                                  );
                                },
                                icon: const Icon(Icons.more_vert),
                              ),
                            )
                          ]),
                          5.getH(),
                          Text(
                            '\$${list[index].price}',
                            style: AppTextStyles.sfProRoundedBold.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          Text(list[index].productName,
                              maxLines: 2,
                              style: AppTextStyles.sfProRoundedRegular
                                  .copyWith(fontSize: 20)),
                          Text(list[index].productDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.sfProRoundedRegular.copyWith(
                                  color: Colors.black.withOpacity(0.4))),
                        ],
                      );
                    },
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

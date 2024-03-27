import 'package:flutter/material.dart';
import 'package:planet_phone_dashboard/screens/tabs/products/products_screen.dart';
import 'package:planet_phone_dashboard/screens/tabs/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/images/app_images.dart';
import '../../view_models/tab_view_model.dart';
import 'categories/categories_screen.dart';
import 'home/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const ProductsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.black,
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.home, color: Colors.grey, height: 24),
            label: "Home",
            activeIcon: Image.asset(AppImages.home, height: 24),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.category, color: Colors.grey, height: 24),
            label: "Categories",
            activeIcon: Image.asset(AppImages.category, height: 24),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.cart, color: Colors.grey, height: 24),
            label: "Products",
            activeIcon: Image.asset(AppImages.cart, height: 24),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.profileTab,
                color: Colors.grey, height: 24),
            label: "Profile",
            activeIcon: Image.asset(AppImages.profileTab, height: 24),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kshk/features/cart/presentation/view/cart_view.dart';
import 'package:kshk/features/home/presentation/view/widgets/custom_button_navigation_bar.dart';
import 'package:kshk/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:kshk/features/profile/presentation/view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeViewBody(),
      const Center(child: Text('Categories')),
      const CartView(),
      const ProfileView(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

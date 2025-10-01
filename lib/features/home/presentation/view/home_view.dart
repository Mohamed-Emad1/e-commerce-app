import 'package:flutter/material.dart';
import 'package:kshk/features/home/presentation/view/widgets/custom_button_navigation_bar.dart';
import 'package:kshk/features/home/presentation/view/widgets/home_view_body.dart';

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
      HomeViewBody(),
      Center(child: Text('Categories')),
      Center(child: Text('Cart')),
      Center(child: Text('Profile')),
    ];
    
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
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



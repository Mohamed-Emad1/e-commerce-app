import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 80,
      elevation: 0,
      selectedIndex: currentIndex,
      onDestinationSelected: onIndexChanged,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.category_outlined),
          selectedIcon: Icon(Icons.category),
          label: 'Categories',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          selectedIcon: Icon(Icons.shopping_bag),
          label: 'Cart',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

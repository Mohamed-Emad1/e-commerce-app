import 'package:flutter/material.dart';
import 'package:kshk/generated/l10n.dart';

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
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: S.of(context).home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.category_outlined),
          selectedIcon: const Icon(Icons.category),
          label: S.of(context).categories,
        ),
        NavigationDestination(
          icon: const Icon(Icons.shopping_bag_outlined),
          selectedIcon: const Icon(Icons.shopping_bag),
          label: S.of(context).cart,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: S.of(context).profile,
        ),
      ],
    );
  }
}

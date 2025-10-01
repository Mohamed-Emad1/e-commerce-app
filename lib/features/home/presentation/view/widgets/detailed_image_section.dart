import 'package:flutter/material.dart';
import 'package:kshk/features/home/presentation/view/detailed_view_screen.dart';

class DetailedImageSection extends StatelessWidget {
  const DetailedImageSection({super.key, required this.widget});

  final DetailedViewScreen widget;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          widget.item.imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}

// Size Widget

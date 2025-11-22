import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: widget.item.imagePath,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          width: double.infinity,
          memCacheHeight: 600,
          memCacheWidth: 400,
        ),
      ),
    );
  }
}

// Size Widget

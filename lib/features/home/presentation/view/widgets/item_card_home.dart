import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/utils/models/favorite.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemCardHome extends StatelessWidget {
  const ItemCardHome({super.key, required this.item, required this.enabled});
  final ItemCardEntity item;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final favoriteService = getIt<FavoriteService>();
    return Skeletonizer(
      enabled: enabled,
      child: ListenableBuilder(
        listenable: favoriteService,
        builder: (context, child) {
          final isFavorite = favoriteService.isFavorite(item);
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kDetailedScreen, extra: item);
            },
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(item.imagePath, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.title,
                        style: AppStyles.size16W600(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: AppStyles.size14W600(context),
                            ),
                          ),
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              onPressed: () {
                                getIt<FavoriteService>().toggleFavorite(item);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

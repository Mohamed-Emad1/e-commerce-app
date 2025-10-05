import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/utils/helper_functions/home_card_entity_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemCardHome extends StatelessWidget {
  const ItemCardHome({super.key, required this.item, required this.enabled});
  final ItemCardEntity item;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final favoriteService = getIt<HomeCardEntityList>();
    return Skeletonizer(
      enabled: enabled,
      child: ListenableBuilder(
        listenable: favoriteService,
        builder: (context, child) {
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
                            child: CachedNetworkImage(
                              imageUrl: item.imagePath,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              memCacheHeight: 600,
                              memCacheWidth: 400,
                            ),
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
                                getIt<HomeCardEntityList>().toggleFavorite(
                                  item,
                                );
                              },
                              icon: Icon(
                                item.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: item.isFavorite ? Colors.red : Colors.grey,
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

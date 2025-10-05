import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/dummy_cards.dart';
import 'package:kshk/core/utils/helper_functions/home_card_entity_list.dart';
// import 'package:kshk/core/utils/models/favorite.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/features/home/presentation/cubits/product_cubit/products_cubit.dart';
import 'package:kshk/features/home/presentation/view/widgets/item_card_home.dart';
import 'package:kshk/generated/l10n.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).all_products,
              style: AppStyles.size30W700(context),
            ),
          ),
          BlocConsumer<ProductsCubit, ProductsState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case ProductsError:
                  final errorState = state as ProductsError;
                  buildScaffoldSnackBar(context, errorState.message);
                  break;
                default:
                  break;
              }
            },
            builder: (context, state) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: state is ProductsSuccess
                        ? getIt.get<HomeCardEntityList>().items.length
                        : 0,
                    itemBuilder: (context, index) {
                      return ItemCardHome(
                        enabled: state is ProductsLoading,
                        item: state is ProductsSuccess
                            ? getIt.get<HomeCardEntityList>().items[index]
                            : dummyItems[index],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

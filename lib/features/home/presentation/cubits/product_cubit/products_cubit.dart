import 'package:bloc/bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/home_card_entity_list.dart'
    show HomeCardEntityList;
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:kshk/features/home/domain/repo/product_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    final result = await productRepo.getProducts();
    result.fold((failure) => emit(ProductsError(failure.toString())), (
      products,
    ) {
      getIt.get<HomeCardEntityList>().clearList();
      getIt.get<HomeCardEntityList>().addToItems(products);
      emit(ProductsSuccess(products)); //! TODO: REMOVE PRODUCTS FROM STATE
    });
  }
}

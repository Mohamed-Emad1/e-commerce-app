import 'package:bloc/bloc.dart';
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
    result.fold(
      (failure) => emit(ProductsError(failure.toString())),
      (products) => emit(ProductsSuccess(products)),
    );
  }
}

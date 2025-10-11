import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kshk/core/Services/database_service.dart';
import 'package:kshk/core/Services/fire_store_service.dart';
import 'package:kshk/core/Services/firebase_auth_service.dart';
import 'package:kshk/core/Services/payment_service.dart';
import 'package:kshk/core/cubits/darkmode/darkmode_cubit.dart';
import 'package:kshk/core/cubits/language_cubit/language_cubit.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/helper_functions/home_card_entity_list.dart';
import 'package:kshk/features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';
import 'package:kshk/features/cart/data/repo_impl/order_repo_impl.dart';
import 'package:kshk/features/cart/data/repo_impl/payment_repo_imp.dart';
import 'package:kshk/features/cart/domain/repo/order_repo.dart';
import 'package:kshk/features/cart/domain/repo/payment_repo.dart';
import 'package:kshk/features/home/data/repo_impl/product_repo_impl.dart';
import 'package:kshk/features/home/domain/repo/product_repo.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Core services
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<HomeCardEntityList>(HomeCardEntityList());
  getIt.registerSingleton<CartItemsList>(CartItemsList());

  // Repositories
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<OrderRepo>(
    OrderRepoImpl(fireStoreService: getIt<DatabaseService>()),
  );

  getIt.registerSingleton<DarkModeCubit>(DarkModeCubit());
  getIt.registerSingleton<LanguageCubit>(LanguageCubit());

  getIt.registerSingleton<ProductRepo>(
    ProductRepoImpl(databaseService: getIt<DatabaseService>()),
  );

  getIt.registerSingleton<PaymentRepo>(PaymentRepoImp(
    paymentService: PaymentService(),
  ));

  getIt.registerSingleton<Dio>(
    Dio()
  );
}

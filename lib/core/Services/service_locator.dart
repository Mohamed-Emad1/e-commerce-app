import 'package:get_it/get_it.dart';
import 'package:kshk/core/Services/database_service.dart';
import 'package:kshk/core/Services/fire_store_service.dart';
import 'package:kshk/core/Services/firebase_auth_service.dart';
import 'package:kshk/core/cubits/darkmode/darkmode_cubit.dart';
import 'package:kshk/core/cubits/language_cubit/language_cubit.dart';
import 'package:kshk/core/utils/models/favorite.dart';
import 'package:kshk/features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Core services
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FavoriteService>(FavoriteService());

  // Repositories
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<DarkModeCubit>(DarkModeCubit());
  getIt.registerSingleton<LanguageCubit>(LanguageCubit());
}

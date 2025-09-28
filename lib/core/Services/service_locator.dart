import 'package:get_it/get_it.dart';
import 'package:kshk/core/Services/firebase_auth_service.dart';
import 'package:kshk/features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
    getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(
      firebaseAuthService: getIt<FirebaseAuthService>(),
    ),
  );
}
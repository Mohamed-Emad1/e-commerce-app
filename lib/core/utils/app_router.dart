import 'package:go_router/go_router.dart';
import 'package:kshk/features/home/presentation/view/home_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = '/';
  static const String kHomeView = '/home';

  static final router = GoRouter(
    initialLocation: kOnboardingView,
    routes: [
      GoRoute(
        path: kHomeView,
        builder: (context, state) =>
            const HomeView(),
      ),  
    ],
  );
}

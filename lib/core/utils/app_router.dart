import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';
import 'package:kshk/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:kshk/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:kshk/features/auth/presentation/view/signIN.dart';
import 'package:kshk/features/auth/presentation/view/signup.dart';
import 'package:kshk/features/home/presentation/view/home_view.dart';
import 'package:kshk/features/onboarding/presentation/view/onboarding_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = '/onboarding';
  static const String kHomeView = '/home';
  static const String kSignin = '/kSignin';
  static const String kSignup = '/signup';

  static final router = GoRouter(
    initialLocation: kOnboardingView,
    routes: [
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kSignin,
        builder: (context, state) => BlocProvider(
          create: (context) => SigninCubit(
            getIt<AuthRepo>(),
          ),
          child: const Signin(),
        ),
      ),
      GoRoute(
        path: kSignup,
        builder: (context, state) => BlocProvider(
          create: (context) => SignupCubit(getIt<AuthRepo>()),
          child: const Signup(),
        ),
      ),
    ],
  );
}

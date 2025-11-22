import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';
import 'package:kshk/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:kshk/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:kshk/features/auth/presentation/view/signIN.dart';
import 'package:kshk/features/auth/presentation/view/signup.dart';
import 'package:kshk/features/cart/domain/repo/order_repo.dart';
import 'package:kshk/features/cart/domain/repo/payment_repo.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/features/cart/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:kshk/features/cart/presentation/view/checkout_view.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';
import 'package:kshk/features/home/domain/repo/product_repo.dart';
import 'package:kshk/features/home/presentation/cubits/product_cubit/products_cubit.dart';
import 'package:kshk/features/home/presentation/view/detailed_view_screen.dart';
import 'package:kshk/features/home/presentation/view/home_view.dart';
import 'package:kshk/features/onboarding/presentation/view/onboarding_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = '/onboarding';
  static const String kHomeView = '/home';
  static const String kSignin = '/kSignin';
  static const String kSignup = '/signup';
  static const String kProfile = '/profile';
  static const String kSettings = '/settings';
  static const String kCart = '/cart';
  static const String kDetailedScreen = '/detailedScreen';
  static const String kCheckout = '/checkout';

  static final router = GoRouter(
    initialLocation: kOnboardingView,
    routes: [
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              ProductsCubit(getIt<ProductRepo>())..fetchProducts(),
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: kSignin,
        builder: (context, state) => BlocProvider(
          create: (context) => SigninCubit(getIt<AuthRepo>()),
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
      GoRoute(
        path: kDetailedScreen,
        builder: (context, state) =>
            DetailedViewScreen(item: state.extra as ItemCardEntity),
      ),
      GoRoute(
        path: kCheckout,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => OrderCubit(getIt<OrderRepo>())),
              BlocProvider(
                create: (context) => PaymentCubit(getIt<PaymentRepo>()),
              ),
            ],
            child: const CheckoutView(),
          );
        },
      ),
    ],
  );
}

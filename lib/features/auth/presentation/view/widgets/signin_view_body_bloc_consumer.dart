import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/core/widgets/custom_modal_progress_hud.dart';
import 'package:kshk/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signin_view_body.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        switch (state) {
          case SigninSuccess():
            GoRouter.of(context).go(AppRouter.kHomeView);
            break;
          case SigninFailure(:final errorMessage):
            buildScaffoldSnackBar(context, errorMessage);
          case SigninLoading():
          case SigninInitial():
            // No action needed for these states
            break;
        }
      },
      builder: (context, state) {
        return CustomModalProgressHud(
          isLoading: state is SigninLoading,
          child: const SigninViewBody(),
        );
      },
    );
  }
}

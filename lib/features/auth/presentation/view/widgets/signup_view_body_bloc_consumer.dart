import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/core/widgets/custom_modal_progress_hud.dart';
import 'package:kshk/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_view_body.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else if (state is SignupFailure) {
          buildScaffoldSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return CustomModalProgressHud(
          isLoading: state is SignupLoading,
          child: SignupViewBody());
      },
    );
  }
}

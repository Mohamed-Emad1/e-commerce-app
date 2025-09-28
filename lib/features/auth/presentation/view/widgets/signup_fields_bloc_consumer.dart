import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/widgets/custom_modal_progress_hud.dart';
import 'package:kshk/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_form_fields.dart';

class SignupFieldsBlocConsumer extends StatelessWidget {
  const SignupFieldsBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          // Navigate to the home screen or show a success message
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else if (state is SignupFailure) {
          // Show an error message
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return CustomModalProgressHud(
          isLoading: state is SignupLoading,
          child: const SignupFormFields(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/auth/presentation/view/widgets/dont_have_an_account.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signin_fields.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_header.dart';
import 'package:kshk/generated/l10n.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignupHeader(),

          SigninFields(),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              S.of(context).forgot_password,
              style: AppStyles.size14W600(
                context,
              ).copyWith(color: AppColors.primaryText),
            ),
          ),
          CustomButton(text: S.of(context).sign_in, onPressed: () {}),

          DontHaveAnAccount(),
        ],
      ),
    );
  }
}

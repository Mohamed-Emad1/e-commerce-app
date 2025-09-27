import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: S.of(context).already_have_an_account,
            style: AppStyles.size16W400(context),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    GoRouter.of(context).pop();
                  },
                text: ' ${S.of(context).sign_in}',
                style: AppStyles.size14W600(context).copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class SigninHeader extends StatelessWidget {
  const SigninHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_open_rounded,
          color: AppColors.primaryText,
          size: 80,
          semanticLabel: 'Lock',
        ),
        Text(
          S.of(context).welcome,
          style: AppStyles.size36W700(context),
          textAlign: TextAlign.center,
        ),
        Text(
          S.of(context).sign_in_to_continue,
          style: AppStyles.size16W400(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

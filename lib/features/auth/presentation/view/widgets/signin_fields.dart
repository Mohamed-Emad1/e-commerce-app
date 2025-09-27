import 'package:flutter/material.dart';
import 'package:kshk/core/widgets/custom_text_form_field.dart';
import 'package:kshk/generated/l10n.dart';

class SigninFields extends StatelessWidget {
  const SigninFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        CustomTextFormField(
          hintText: S.of(context).email,
          prefixIcon: Icons.mail_outline,
        ),
        CustomTextFormField(
          hintText: S.of(context).password,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
      ],
    );
  }
}

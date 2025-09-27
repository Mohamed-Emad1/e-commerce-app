import 'package:flutter/material.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_form_fields.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_header.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SignupHeader(), SignupFormFields()],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_form_fields.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_header.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SignupHeader(), SignupFormFields()],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_view_body.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupViewBody(),
    );
  }
}
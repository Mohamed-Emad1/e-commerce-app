import 'package:flutter/material.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signup_view_body_bloc_consumer.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SignupViewBodyBlocConsumer()));
  }
}

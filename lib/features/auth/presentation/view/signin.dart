import 'package:flutter/material.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signin_view_body_bloc_consumer.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SigninViewBodyBlocConsumer()));
  }
}

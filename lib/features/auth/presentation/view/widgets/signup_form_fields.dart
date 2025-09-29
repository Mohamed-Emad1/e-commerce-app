import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/core/widgets/custom_text_form_field.dart';
import 'package:kshk/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/already_have_account.dart';
import 'package:kshk/generated/l10n.dart';

class SignupFormFields extends StatefulWidget {
  const SignupFormFields({super.key});

  @override
  State<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends State<SignupFormFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;
  String? name;
  String? confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          CustomTextFormField(
            hintText: S.of(context).name,
            prefixIcon: Icons.person_outline,
            onSaved: (val) {
              name = val;
            },
          ),
          CustomTextFormField(
            hintText: S.of(context).email,
            prefixIcon: Icons.mail_outline,
            isEmail: true,
            onSaved: (val) {
              email = val;
            },
          ),
          CustomTextFormField(
            hintText: S.of(context).password,
            prefixIcon: Icons.lock,
            obscureText: true,
            onSaved: (val) {
              password = val;
            },
          ),
          CustomTextFormField(
            hintText: S.of(context).confirm_password,
            prefixIcon: Icons.lock,
            obscureText: true,
            onSaved: (val) {
              confirmPassword = val;
            },
          ),

          CustomButton(
            text: S.of(context).sign_up,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (password != confirmPassword) {
                  buildScaffoldSnackBar(
                    context,
                    S.of(context).passwords_do_not_match,
                    color: const Color.fromARGB(255, 187, 174, 62),
                  );
                  return;
                } else {
                  _formKey.currentState!.save();
                  // You can now use the email and password variables
                  log('Email: $email, Password: $password');
                  BlocProvider.of<SignupCubit>(
                    context,
                  ).createUserWithEmailAndPassword(email!, password!, name!);
                }
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
          ),

          AlreadyHaveAccount(),
        ],
      ),
    );
  }
}

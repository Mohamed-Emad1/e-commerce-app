import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/core/widgets/custom_text_form_field.dart';
import 'package:kshk/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/dont_have_an_account.dart';
import 'package:kshk/generated/l10n.dart';

class SigninFormFields extends StatefulWidget {
  const SigninFormFields({super.key});

  @override
  State<SigninFormFields> createState() => _SigninFormFieldsState();
}

class _SigninFormFieldsState extends State<SigninFormFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: _formKey,
      child: Column(
        spacing: 15,
        children: [
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

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              S.of(context).forgot_password,
              style: AppStyles.size14W600(
                context,
              ).copyWith(color: AppColors.primaryText),
            ),
          ),
          CustomButton(
            text: S.of(context).sign_in,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // You can now use the email and password variables
                log('Email: $email, Password: $password');
                BlocProvider.of<SigninCubit>(
                  context,
                ).signInWithEmailAndPassword(email!, password!);
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
          ),

          const DontHaveAnAccount(),
        ],
      ),
    );
  }
}

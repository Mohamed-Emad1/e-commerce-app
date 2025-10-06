import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/utils/assets.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signin_form_fields.dart';
import 'package:kshk/features/auth/presentation/view/widgets/signin_header.dart';
import 'package:kshk/features/auth/presentation/view/widgets/social_media_icon.dart';
import 'package:kshk/generated/l10n.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SigninHeader(),
            SigninFormFields(),
            Text(
              S.of(context).or_sign_in_with,
              style: AppStyles.size14W600(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                SocialMediaIcon(
                  iconPath: Assets.assetsImagesGoogleIcon,
                  onTap: () {
                    BlocProvider.of<SigninCubit>(context).signInWithGoogle();
                  },
                ),
                SocialMediaIcon(
                  iconPath: Assets.assetsImagesFacebookIcon,
                  onTap: () {
                    BlocProvider.of<SigninCubit>(context).signInWithFacebook();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

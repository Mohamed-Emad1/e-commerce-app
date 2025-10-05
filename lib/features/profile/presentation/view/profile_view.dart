import 'package:flutter/material.dart';
import 'package:kshk/core/utils/helper_functions/build_app_bar.dart';
import 'package:kshk/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:kshk/generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, title: Text(S.of(context).settings)),
      body: SafeArea(child: const ProfileViewBody()),
    );
  }
}

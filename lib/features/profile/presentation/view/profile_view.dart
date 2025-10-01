import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kshk/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:kshk/generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        centerTitle: true,
        leading: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
      ),
      body: SafeArea(child: const ProfileViewBody()),
    );
  }
}

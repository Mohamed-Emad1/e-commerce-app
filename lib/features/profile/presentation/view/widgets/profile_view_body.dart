import 'package:flutter/material.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';
import 'package:kshk/features/profile/presentation/view/widgets/dark_mode_switch.dart';
import 'package:kshk/features/profile/presentation/view/widgets/language_switch.dart';
import 'package:kshk/generated/l10n.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final UserEntity user = getUserData();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            title: Text(user.fullName, style: AppStyles.size18W600(context)),
            subtitle: Text(
              S.of(context).edit_name,
              style: AppStyles.size14W600(context),
            ),
          ),

          DarkModeSwitch(),

          LanguageSwitch(),
        ],
      ),
    );
  }
}

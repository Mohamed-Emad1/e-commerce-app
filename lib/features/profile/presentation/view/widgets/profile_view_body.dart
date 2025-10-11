import 'package:flutter/material.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';
import 'package:kshk/features/profile/presentation/view/widgets/dark_mode_switch.dart';
import 'package:kshk/features/profile/presentation/view/widgets/helper/open_editing_dialog.dart';
import 'package:kshk/features/profile/presentation/view/widgets/language_switch.dart';
import 'package:kshk/generated/l10n.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late final TextEditingController _nameController;
  String name = getUserData().fullName;
  @override
  void initState() {
    _nameController = TextEditingController(text: name);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(name, style: AppStyles.size18W600(context)),
            subtitle: GestureDetector(
              onTap: () async {
                final newName = await openEditNameDialog(
                  context,
                  _nameController,
                );
                if (newName != null && newName.isNotEmpty) {
                  setState(() {
                    name = newName; // Update the name variable
                    _nameController.text = newName; // Keep controller in sync
                    getIt.get<AuthRepo>().saveUserData(
                      user: UserEntity(
                        uid: getUserData().uid,
                        email: getUserData().email,
                        fullName: name,
                      ),
                    );
                  });
                }
              },
              child: Text(
                S.of(context).edit_name,
                style: AppStyles.size14W600(context),
              ),
            ),
          ),

          DarkModeSwitch(),

          LanguageSwitch(),
        ],
      ),
    );
  }
}

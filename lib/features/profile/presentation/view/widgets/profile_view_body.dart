import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/utils/constants.dart';
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
  File? _selectedImage;
  late final TextEditingController _nameController;
  String name = getUserData().fullName;
  @override
  void initState() {
    _nameController = TextEditingController(text: name);
    super.initState();
    _loadSavedImage();
  }

    void _loadSavedImage() {
    final savedImagePath = SharedPreferencesSingleton.getString(
      kUserProfileImage,
    );
    if (savedImagePath !=null && savedImagePath.isNotEmpty) {
      final file = File(savedImagePath);
      if (file.existsSync()) {
        setState(() {
          _selectedImage = file;
        });
      } else {
        // Clear invalid path
        SharedPreferencesSingleton.setstring(
          kUserProfileImage,
          '',
        );
      }
    }
  }

    Future<void> _saveImagePath(String path) async {
    await SharedPreferencesSingleton.setstring(kUserProfileImage, path);
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
            leading: GestureDetector(
              onTap: () async {
                await openEditProfileImageFromGallery(context);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: _selectedImage == null
                    ? const AssetImage('assets/images/user.png')
                          as ImageProvider
                    : FileImage(_selectedImage!),
              ),
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

  Future<void> openEditProfileImageFromGallery(BuildContext context) async {
    final XFile? returnImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    if (returnImage != null) {
      final imagePath = returnImage.path;
      await _saveImagePath(imagePath);

      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }
}

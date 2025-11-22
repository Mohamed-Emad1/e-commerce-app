import 'package:flutter/material.dart';
import 'package:kshk/generated/l10n.dart';

Future<String?> openEditNameDialog<String>(
  BuildContext context,
  TextEditingController nameController,
) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(S.of(context).edit_name),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: S.of(context).edit_your_name),
        ),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(nameController.text); // Close the dialog
            },
            child: Text(S.of(context).edit_your_name),
          ),
        ],
      );
    },
  );
}

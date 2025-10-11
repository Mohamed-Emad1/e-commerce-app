import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kshk/generated/l10n.dart';

Future<String?> openEditNameDialog<String>(BuildContext context,
    TextEditingController _nameController) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(S.of(context).edit_name),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(hintText: S.of(context).edit_your_name),
        ),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(_nameController.text); // Close the dialog
            },
            child: Text(S.of(context).edit_your_name),
          ),
        ],
      );
    },
  );
}

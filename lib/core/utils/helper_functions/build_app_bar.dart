import 'dart:io';

import 'package:flutter/material.dart';

AppBar buildCustomAppBar(BuildContext context, {required Widget title}) {
  return AppBar(
    title: title,
    centerTitle: true,
    leading: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
  );
}

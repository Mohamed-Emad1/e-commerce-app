import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomModalProgressHud extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomModalProgressHud({
    super.key,
    required this.child,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: isLoading, child: child);
  }
}

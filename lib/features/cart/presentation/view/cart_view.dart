import 'package:flutter/material.dart';
import 'package:kshk/core/utils/helper_functions/build_app_bar.dart';
import 'package:kshk/generated/l10n.dart';
import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, title: Text(S.of(context).cart)),
      body: SafeArea(child: const CartViewBody()),
    );
  }
}

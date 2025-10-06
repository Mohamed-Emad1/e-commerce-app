import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/features/cart/presentation/view/widgets/payment_method_view.dart';
import 'package:kshk/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PaymentViewBlocConsumer extends StatelessWidget {
  const PaymentViewBlocConsumer({super.key, required this.runtimeType});

  @override
  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case OrderFailure:
            final errorState = state as OrderFailure;
            buildScaffoldSnackBar(context, errorState.errorMessage);
            break;
          case OrderSuccess:
            GoRouter.of(context).pop();
            getIt.get<CartItemsList>().clearItems();
            buildScaffoldSnackBar(context, S.of(context).order_placed);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Center(
          child: ModalProgressHUD(
            inAsyncCall: state is OrderLoading,
            child: PaymentMethodView(),
          ),
        );
      },
    );
  }
}

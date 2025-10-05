import 'package:flutter/material.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/helper_functions/build_app_bar.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/cart/presentation/view/widgets/address_view.dart';
import 'package:kshk/features/cart/presentation/view/widgets/order_summary_view.dart';
import 'package:kshk/features/cart/presentation/view/widgets/payment_method_view.dart';
import 'package:kshk/generated/l10n.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    if (_pageController.page != null) {
      int page = _pageController.page!.round();
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  String _getTitle(BuildContext context) {
    switch (_currentPage) {
      case 0:
        return S.of(context).address;
      case 1:
        return S.of(context).payment_method;
      case 2:
        return S.of(context).order_summary;
      default:
        return S.of(context).checkout;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartService = getIt.get<CartItemsList>();
    return Scaffold(
      appBar: buildCustomAppBar(
        context,
        title: Text(_getTitle(context), style: AppStyles.size18W700(context)),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          AddressView(pageController: _pageController),
          PaymentMethodView(),
          OrderSummaryView(),
        ],
      ),
    );
  }
}

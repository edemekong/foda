import 'package:flutter/material.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/components/notch_bar.dart';
import 'package:foda/screens/checkout/checkout_state.dart';
import 'package:foda/screens/checkout/pages/cart.dart';
import 'package:foda/screens/checkout/pages/complete_order.dart';
import 'package:foda/screens/checkout/pages/confirm_order.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<CheckoutState>();
    return AppScaffold(
      backgroundColor: AppTheme.black,
      body: Column(
        children: [
          const SizedBox(height: AppTheme.elementSpacing),
          const NotchBar(),
          Expanded(
            child: PageView(
              controller: state.pageController,
              onPageChanged: state.onPageChange,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                CartView(),
                ConfirmOrder(),
                OrderComplete(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

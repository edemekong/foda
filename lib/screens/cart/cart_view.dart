import 'package:flutter/material.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/components/notch_bar.dart';
import 'package:foda/screens/cart/cart_state.dart';
import 'package:foda/screens/cart/components/cart_items.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:foda/utils/common.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartState>();
    fodaPrint(state.cartItems);
    return AppScaffold(
      body: Column(
        children: [
          const SizedBox(height: AppTheme.elementSpacing),
          const NotchBar(),
          const SizedBox(height: AppTheme.elementSpacing),
          Text(
            "Your Order",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: AppTheme.orange,
                ),
          ),
          if (state.cart.isEmpty) ...[
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_basket_outlined,
                  size: 100,
                  color: AppTheme.white,
                ),
                const SizedBox(height: AppTheme.cardPadding),
                Text(
                  "Cart is Empty",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            const Spacer(),
          ] else ...[
            const CartItemList(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: FodaButton(
                title: 'Confirm Order',
                gradiant: const [
                  AppTheme.orange,
                  AppTheme.red,
                ],
                onTap: () {},
              ),
            ),
            const SizedBox(height: kToolbarHeight),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/screens/cart/cart_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return AppBar(
      leading: Image.asset(IconPath.menu),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        InkWell(
          onTap: () => state.openCartView(context),
          child: Builder(builder: (context) {
            final cartState = context.watch<CartState>();

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.elementSpacing),
                  decoration: BoxDecoration(
                    color: AppTheme.black,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Image.asset(IconPath.bag),
                ),
                if (cartState.cart.isNotEmpty) ...[
                  Positioned(
                    right: -2,
                    child: Text(
                      cartState.cart.length.toString(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.red,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
        const SizedBox(width: AppTheme.elementSpacing),
      ],
    );
  }
}

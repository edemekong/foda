import 'package:flutter/material.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/screens/cart/cart_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class FoodDetailAppBar extends StatelessWidget {
  const FoodDetailAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();

    return AppBar(
      leading: IconButton(
        color: AppTheme.orange,
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        InkWell(
          onTap: () => overviewState.openCartView(context),
          child: Builder(builder: (context) {
            final cartState = context.watch<CartState>();

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.darkBlue,
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

import 'package:flutter/material.dart';
import 'package:foda/screens/food_detail/food_detail_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CartActions extends StatelessWidget {
  const CartActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();
    final state = context.watch<FoodDetailState>();

    if (state.cartItem == null) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing, horizontal: AppTheme.elementSpacing),
          decoration: BoxDecoration(
            color: AppTheme.black,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  overviewState.addToCart(state.food, false);
                },
                child: Icon(
                  Icons.remove,
                  size: 15,
                  color: state.cartItem!.quantity > 1 ? AppTheme.white : null,
                ),
              ),
              const SizedBox(width: AppTheme.elementSpacing),
              Text(
                "${state.cartItem?.quantity}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(width: AppTheme.elementSpacing),
              InkWell(
                onTap: () {
                  overviewState.addToCart(state.food);
                },
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: AppTheme.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

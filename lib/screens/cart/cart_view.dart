import 'package:flutter/material.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/models/cart_item.dart';
import 'package:foda/models/food.dart';
import 'package:foda/screens/cart/cart_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:foda/utils/common.dart';
import 'package:provider/provider.dart';

import '../../constant/icon_path.dart';

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
          Text(
            "Your Order",
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: AppTheme.elementSpacing),
          Expanded(
            child: ListView.builder(
              itemCount: state.cart.length + 1,
              itemBuilder: (context, index) {
                if (index == state.cart.length) {
                  return Column(
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "${state.cart.length} Items",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppTheme.grey,
                            ),
                      ),
                      Text(
                        "\$${state.getTotalAmount}",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: AppTheme.red,
                            ),
                      ),
                      const SizedBox(height: kToolbarHeight),
                    ],
                  );
                }
                return CartItemCard(
                  cartItem: state.cart[index],
                  food: state.cartItems[state.cart[index].foodId],
                );
              },
            ),
          ),
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
          const SizedBox(height: AppTheme.cardPadding),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Food? food;
  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<CartState>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppTheme.red,
                  image: DecorationImage(
                    image: NetworkImage(food!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: AppTheme.elementSpacing * 0.5),
              Text(
                "${food?.title}",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: AppTheme.elementSpacing * 0.25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$${food!.price * cartItem.quantity}",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppTheme.red,
                        ),
                  ),
                  Text(
                    " x ${cartItem.quantity}",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppTheme.grey,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
            ],
          ),
        ),
        Positioned(
          right: 150,
          top: -10,
          child: Container(
            padding: const EdgeInsets.all(AppTheme.elementSpacing * 0.5),
            decoration: const BoxDecoration(
              color: AppTheme.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              "${cartItem.quantity}",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: AppTheme.white,
                  ),
            ),
          ),
        ),
        Positioned(
          right: 120,
          top: 10,
          child: FodaCircleButton(
            title: "",
            gradiant: const [
              AppTheme.darkBlue,
              AppTheme.darkBlue,
            ],
            icon: const Icon(
              Icons.close,
              color: AppTheme.white,
              size: 15,
            ),
            onTap: () {
              state.removCartItem(food!);
            },
          ),
        ),
      ],
    );
  }
}

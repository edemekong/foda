import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/models/cart_item.dart';
import 'package:foda/models/food.dart';
import 'package:foda/screens/checkout/checkout_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Food? food;
  final bool showDetail;
  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.food,
    this.showDetail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppTheme.red,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(.8),
                      spreadRadius: 5,
                      blurRadius: 15,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(food!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              if (showDetail) ...[
                Column(
                  children: [
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
                                fontWeight: FontWeight.bold,
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
              ],
            ],
          ),
        ),
        if (showDetail) ...[
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
            right: MediaQuery.of(context).size.width * 0.33,
            top: 20,
            child: FodaCircleButton(
              title: "",
              padding: const EdgeInsets.all(6),
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
      ],
    );
  }
}

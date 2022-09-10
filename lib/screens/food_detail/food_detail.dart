import 'package:flutter/material.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/models/food.dart';
import 'package:foda/screens/food_detail/components/appbar.dart';
import 'package:foda/screens/food_detail/components/cart_actions.dart';
import 'package:foda/screens/food_detail/components/detail.dart';
import 'package:foda/screens/food_detail/components/food_image.dart';
import 'package:foda/screens/food_detail/food_detail_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const FoodDetailAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  DisplayFoodImage(),
                  SizedBox(height: AppTheme.elementSpacing),
                  CartActions(),
                  SizedBox(height: AppTheme.cardPadding),
                  FoodDetail(),
                  SizedBox(height: AppTheme.elementSpacing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDetailViewWidget extends StatelessWidget {
  final Food food;
  const FoodDetailViewWidget({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodDetailState(food),
      child: const FoodDetailView(),
    );
  }
}

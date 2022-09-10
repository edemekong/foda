import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/screens/food_detail/food_detail_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DisplayFoodImage extends StatelessWidget {
  const DisplayFoodImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overviewState = context.read<OverviewState>();
    final state = context.watch<FoodDetailState>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Hero(
          tag: state.food.id,
          child: Container(
            height: 260,
            width: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.black.withOpacity(.6),
                  spreadRadius: 20,
                  blurRadius: 20,
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(state.food.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: -10,
          bottom: 50,
          child: FodaCircleButton(
            title: "",
            gradiant: const [
              AppTheme.orange,
              AppTheme.orangeDark,
            ],
            icon: const Icon(
              Icons.add,
              color: AppTheme.white,
              size: 30,
            ),
            onTap: () {
              overviewState.addToCart(state.food);
            },
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: FodaCircleButton(
            title: "",
            gradiant: const [
              AppTheme.darkBlue,
              AppTheme.darkBlue,
            ],
            icon: Image.asset(IconPath.favourite),
            onTap: () {
              overviewState.addToFavorite(state.food);
            },
          ),
        ),
      ],
    );
  }
}

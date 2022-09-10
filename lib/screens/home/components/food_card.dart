import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/models/food.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, foodDetailPath, arguments: food);
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(
                tag: food.id,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.black.withOpacity(.6),
                        spreadRadius: 20,
                        blurRadius: 20,
                        offset: const Offset(15, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(food.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
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
                    state.addToCart(food);
                  },
                ),
              ),
              Positioned(
                left: 50,
                bottom: 0,
                child: FodaCircleButton(
                  title: "",
                  gradiant: const [
                    AppTheme.darkBlue,
                    AppTheme.darkBlue,
                  ],
                  icon: Image.asset(IconPath.favourite),
                  onTap: () {
                    state.addToFavorite(food);
                  },
                ),
              ),
              Positioned(
                  left: -120,
                  bottom: 100,
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: AppTheme.elementSpacing * 0.5),
                        Text(
                          "\$ ${food.price}",
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(color: AppTheme.red),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

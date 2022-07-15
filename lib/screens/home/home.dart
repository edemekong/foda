import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/constant/image_path.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../../components/app_scaffold.dart';
import '../../models/food.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.read<OverviewState>();

    return AppScaffold(
      body: Column(
        children: [
          AppBar(
            leading: Image.asset(IconPath.menu),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [Image.asset(IconPath.bag)],
          ),
          Expanded(
            child: ValueListenableBuilder<List<Food>>(
                valueListenable: state.foodRepository.foodsNotifier,
                builder: (context, foods, _) {
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      double _scaleFactor = currentPage == index ? 1 : 0.5;
                      Offset offset = currentPage == index ? const Offset(100, 0) : const Offset(220, 400);

                      return Transform.scale(
                        scale: _scaleFactor,
                        child: Transform.translate(
                          offset: offset,
                          child: FoodCard(
                            food: foods[index],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(food.imageUrl),
                  fit: BoxFit.cover,
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
                onTap: () {},
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
                onTap: () {},
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
    );
  }
}

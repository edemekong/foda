import 'package:flutter/material.dart';
import 'package:foda/components/base_state.dart';
import 'package:foda/repositories/cart_repository.dart';
import 'package:foda/repositories/food_repository.dart';
import 'package:foda/repositories/user_repository.dart';
import 'package:foda/screens/cart/cart_view.dart';
import 'package:foda/services/get_it.dart';
import 'package:foda/services/navigation_service.dart';

import '../components/cupertino_model_route.dart';
import '../models/food.dart';

class OverviewState extends BaseState {
  final navigationService = locate<NavigationService>();
  final userRepo = locate<UserRepository>();

  final foodRepository = locate<FoodRepository>();
  final cartRepo = locate<CartRepository>();

  PageController pageController = PageController();

  OverviewState() {
    foodRepository.getFoods();
    cartRepo.getCart(userRepo.currentUserUID!);
    navigationService.currentIndexNotifier.addListener(_currentIndexListener);
  }

  void animateToPage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _currentIndexListener() {
    animateToPage(navigationService.currentIndexNotifier.value);
  }

  void addToCart(Food food) {
    cartRepo.addOrRemoveFoodFromCart(userRepo.currentUserUID!, food);
  }

  void addToFavorite(Food food) {
    userRepo.addFoodToFavorite(userRepo.currentUserUID!, food);
  }

  void openCartView(BuildContext context) {
    navigationService.setNavigationBar = false;
    showSnapModelBottomSheet(
      context: context,
      enableDrag: true,
      builder: (_) => const CartView(),
    ).then((value) {
      navigationService.setNavigationBar = true;
    });
  }
}

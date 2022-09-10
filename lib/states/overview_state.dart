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

  void addToCart(Food food, [bool isAdding = true]) {
    cartRepo.addOrRemoveFoodFromCart(userRepo.currentUserUID!, food, isAdding: isAdding);
  }

  void addToFavorite(Food food) {
    userRepo.addFoodToFavorite(userRepo.currentUserUID!, food);
  }

  Future<void> openCartView(BuildContext context) async {
    await showSnapModelBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      topRadius: const Radius.circular(40),
      builder: (_) => const CartView(),
    );
  }
}

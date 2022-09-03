import 'package:foda/components/base_state.dart';
import 'package:foda/models/food.dart';
import 'package:foda/repositories/cart_repository.dart';
import 'package:foda/repositories/food_repository.dart';
import 'package:foda/repositories/user_repository.dart';
import 'package:foda/utils/common.dart';

import '../../models/cart_item.dart';
import '../../services/get_it.dart';

class CartState extends BaseState {
  final foodRepo = locate<FoodRepository>();
  final userRepo = locate<UserRepository>();

  final _cartRepo = locate<CartRepository>();

  Map<String, Food> cartItems = {};
  List<CartItem> cart = [];

  CartState() {
    _cartListener();
    _cartRepo.cartNotifier.addListener(_cartListener);
  }

  @override
  void dispose() {
    super.dispose();
    _cartRepo.cartNotifier.removeListener(_cartListener);
  }

  int get getTotalAmount {
    int total = 0;
    cartItems.forEach((key, value) {
      try {
        final cartItem = cart.firstWhere((item) => item.foodId == key);
        final newFood = value.copyWith(category: cartItem.category);
        total += cartItem.quantity * newFood.price;
      } catch (_) {}
    });
    return total;
  }

  void _cartListener() async {
    cart = _cartRepo.cartNotifier.value;
    fodaPrint(cart);
    notifyListeners();

    _cartRepo.cartNotifier.value.forEach(
      ((CartItem item) async {
        final getFood = await foodRepo.getFood(item.foodId);
        if (getFood.isRight) {
          final product = getFood.right;
          cartItems[item.foodId] = product;
          notifyListeners();
        }
      }),
    );
  }

  void removCartItem(Food food) {
    _cartRepo.removeFoodFromCart(userRepo.currentUserUID!, food);
  }
}

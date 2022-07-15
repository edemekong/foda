import 'package:foda/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../repositories/food_repository.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<FoodRepository>(FoodRepository());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}

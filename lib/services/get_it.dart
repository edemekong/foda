import 'package:foda/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepository>(UserRepository());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/repositories/user_repository.dart';
import 'package:foda/screens/authentication/authentication_view.dart';
import 'package:foda/screens/onboard/onboard_view.dart';
import 'package:foda/screens/overview/overview.dart';
import 'package:foda/services/get_it.dart';

class NavigationService {
  NavigationService._();

  static NavigationService? _instance;

  static NavigationService get intance {
    _instance ??= NavigationService._();
    return _instance!;
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  UserRepository userRepo = locate<UserRepository>();

  ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);
  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);

  List<String> pathToCloseNavigationBar = [
    authPath,
    welcomePath,
  ];

  set setNavigationBar(bool value) {
    showNavigationBar.value = value;
    showNavigationBar.notifyListeners();
  }

  void updateIndex(int value) {
    currentIndexNotifier.value = value;
    if (value == currentIndexNotifier.value) return;
    currentIndexNotifier.notifyListeners();
  }

  String determineHomePath() {
    if (userRepo.currentUserUID != null) {
      return overviewPath;
    }
    return welcomePath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    final routeName = settings.name;
    switch (routeName) {
      case authPath:
        final state = settings.arguments as AuthenticationViewState;
        return navigateToMaterialPageRoute(settings, AuthenticationView(viewState: state));
      case welcomePath:
        return navigateToMaterialPageRoute(settings, const OnboardView());

      case overviewPath:
        return navigateToMaterialPageRoute(settings, const Overview());
    }

    return null;
  }

  MaterialPageRoute navigateToMaterialPageRoute(RouteSettings settings, Widget page,
      {bool maintainState = true, bool fullscreen = false}) {
    return MaterialPageRoute(
      maintainState: maintainState,
      fullscreenDialog: fullscreen,
      settings: settings,
      builder: (_) => page,
    );
  }
}

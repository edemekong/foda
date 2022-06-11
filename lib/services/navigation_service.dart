import 'package:flutter/material.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/screens/authentication/authentication_view.dart';
import 'package:foda/screens/onboard/onboard_view.dart';
import 'package:foda/screens/overview/overview.dart';

class NavigationService {
  NavigationService._();

  static NavigationService? _instance;

  static NavigationService get intance {
    _instance ??= NavigationService._();
    return _instance!;
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

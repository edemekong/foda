import 'package:flutter/material.dart';
import 'package:foda/screens/authentication/authentication_state.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:foda/utils/common.dart';
import 'package:provider/provider.dart';

import 'constant/icon_path.dart';

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ChangeNotifierProvider(create: (_) => OverviewState())
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: NavigationService.intance.showNavigationBar,
          builder: (context, show, _) {
            if (!show) return const SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
              color: AppTheme.darkBlue,
              child: ValueListenableBuilder<int>(
                  valueListenable: NavigationService.intance.currentIndexNotifier,
                  builder: (context, index, _) {
                    return BottomNavigationBar(
                      currentIndex: index,
                      onTap: (index) {
                        NavigationService.intance.updateIndex(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(IconPath.home),
                          activeIcon: Image.asset(IconPath.home, color: AppTheme.orange),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(IconPath.favourite),
                          activeIcon: Image.asset(IconPath.favourite, color: AppTheme.orange),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(IconPath.search),
                          activeIcon: Image.asset(IconPath.search, color: AppTheme.orange),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(IconPath.account),
                          activeIcon: Image.asset(IconPath.account, color: AppTheme.orange),
                          label: "",
                        ),
                      ],
                      elevation: 0,
                      selectedFontSize: 11,
                      unselectedFontSize: 11,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      unselectedLabelStyle: Theme.of(context).textTheme.caption,
                      selectedLabelStyle: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w700),
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                    );
                  }),
            );
          }),
      body: Navigator(
        key: NavigationService.intance.navigatorKey,
        onGenerateRoute: NavigationService.intance.onGeneratedRoute,
        observers: [TabNavigationObservers()],
        initialRoute: NavigationService.intance.determineHomePath(),
      ),
    );
  }
}

class TabNavigationObservers extends RouteObserver<PageRoute<dynamic>> {
  TabNavigationObservers();

  final navigationService = NavigationService.intance;

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    // if (previousRoute is PageRoute && route is PageRoute) {
    final containPreviousRoutePath = navigationService.pathToCloseNavigationBar.contains(previousRoute?.settings.name);

    if (containPreviousRoutePath) {
      navigationService.setNavigationBar = false;
    }

    if (!containPreviousRoutePath) {
      navigationService.setNavigationBar = true;
    }
    // }

    fodaPrint("pop ${route?.settings.name}");
    super.didPop(route!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // if (previousRoute is PageRoute && route is PageRoute) {
    final paths = navigationService.pathToCloseNavigationBar;
    final containRoutePath = paths.contains(route.settings.name);

    fodaPrint("contain => $containRoutePath");

    if (containRoutePath) {
      navigationService.setNavigationBar = false;
    } else {
      navigationService.setNavigationBar = true;
    }
    // }

    fodaPrint("push ${route.settings.name}");

    super.didPush(route, previousRoute);
  }
}

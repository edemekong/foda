import 'package:flutter/material.dart';
import 'package:foda/components/app_bottom_navigation_bar.dart';
import 'package:foda/components/cart_navigation_bar.dart';
import 'package:foda/services/get_it.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/themes/app_theme.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = locate<NavigationService>();
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: navigationService.showNavigationBar,
        builder: (context, show, _) {
          if (!show) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
            color: AppTheme.darkBlue,
            child: ValueListenableBuilder<NavigationBarType>(
              valueListenable: navigationService.showNavigationBarType,
              builder: (context, type, _) {
                if (type == NavigationBarType.cart) {
                  return const CartBottomNavigationBar();
                }
                return AppBottomNavigationBar(navigationService: navigationService);
              },
            ),
          );
        },
      ),
      body: Container(
        color: AppTheme.darkBlue,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: Navigator(
            key: navigationService.navigatorKey,
            onGenerateRoute: navigationService.onGeneratedRoute,
            observers: [TabNavigationObservers()],
            initialRoute: navigationService.determineHomePath(),
          ),
        ),
      ),
    );
  }
}

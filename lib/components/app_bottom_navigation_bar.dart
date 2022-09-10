import 'package:flutter/material.dart';
import 'package:foda/constant/icon_path.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/themes/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.navigationService,
  }) : super(key: key);

  final NavigationService navigationService;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: navigationService.currentIndexNotifier,
        builder: (context, index, _) {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (index) {
              navigationService.updateIndex(index);
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
        });
  }
}

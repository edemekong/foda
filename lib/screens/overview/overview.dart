import 'package:flutter/material.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/screens/account/account.dart';
import 'package:foda/screens/favorite/favorite.dart';
import 'package:foda/screens/search/search.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppTheme.darkBlue,
      body: PageView(
        controller: context.read<OverviewState>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          FavoritePage(),
          SearchPage(),
          AccountPage(),
        ],
      ),
    );
  }
}

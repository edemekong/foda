import 'package:flutter/material.dart';
import 'package:foda/screens/account/account.dart';
import 'package:foda/screens/favorite/favorite.dart';
import 'package:foda/screens/search/search.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/states/overview_state.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: context.read<OverviewState>().pageController,
      children: const [
        HomePage(),
        FavoritePage(),
        SearchPage(),
        AccountPage(),
      ],
    );
  }
}

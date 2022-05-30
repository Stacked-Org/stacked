import 'package:flutter/material.dart';
import 'package:new_architecture/ui/bottom_nav/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import 'bottom_nav_example_viewmodel.dart';
import 'favorites/favorites_view.dart';
import 'history/history_view.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({Key? key}) : super(key: key);

  @override
  BottomNavExampleState createState() => BottomNavExampleState();
}

class BottomNavExampleState extends State<BottomNavExample> {
  final Map<int, Widget> _viewCache = <int, Widget>{};

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          backgroundColor: Colors.white,
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      viewModelBuilder: () => BottomNavExampleViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = const FavoritesView();
          break;
        case 1:
          _viewCache[index] = const HistoryView();
          break;
        case 2:
          _viewCache[index] = const ProfileView();
          break;
      }
    }

    return _viewCache[index]!;
  }
}

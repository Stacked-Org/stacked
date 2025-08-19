import 'package:example/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'bottom_nav_example_viewmodel.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  BottomNavExampleState createState() => BottomNavExampleState();
}

class BottomNavExampleState extends State<BottomNavExample> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: ExtendedNavigator(
          navigatorKey: StackedService.nestedNavigationKey(1),
          initialRoute: BottomNavExampleRoutes.favoritesView,
          router: BottomNavExampleRouter(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          backgroundColor: Colors.white,
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.handleNavigation,
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
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, viewModel, child) =>
          const Scaffold(body: Center(child: Text('Profile'))),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}

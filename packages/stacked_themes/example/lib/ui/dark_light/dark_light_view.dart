import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'dark_light_viewmodel.dart';

class DarkLightView extends StatelessWidget {
  const DarkLightView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DarkLightViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'This adjusts Dark/Light depending on the System brightness setting and if you set themeMode to system in the main file.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    var themeManger = getThemeManager(context);
                    themeManger.toggleDarkLightTheme();
                  },
                  child: Text(
                    'Tapping this toggles Dark/Light theme',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      child: Text('Dark'),
                      color: Colors.grey,
                      onPressed: () {
                        var themeManger = getThemeManager(context);
                        themeManger.setThemeMode(ThemeMode.dark);
                      },
                    ),
                    MaterialButton(
                      child: Text('Light'),
                      color: Colors.grey,
                      onPressed: () {
                        var themeManger = getThemeManager(context);
                        themeManger.setThemeMode(ThemeMode.light);
                      },
                    ),
                    MaterialButton(
                      child: Text('System'),
                      color: Colors.grey,
                      onPressed: () {
                        var themeManger = getThemeManager(context);
                        themeManger.setThemeMode(ThemeMode.system);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => DarkLightViewModel(),
    );
  }
}

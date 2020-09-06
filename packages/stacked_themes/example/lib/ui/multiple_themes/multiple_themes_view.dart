import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'multiple_themes_viewmodel.dart';

class MultipleThemesView extends StatelessWidget {
  const MultipleThemesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<MultipleThemesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Center(
          child: Wrap(
            spacing: 30,
            runSpacing: 20,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: model.themes
                .map(
                  (themeData) => GestureDetector(
                    onTap: () {
                      getThemeManager(context)
                          .selectThemeAtIndex(themeData.index);
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100]),
                      child: Text(themeData.title),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      viewModelBuilder: () => MultipleThemesViewModel(),
    );
  }
}

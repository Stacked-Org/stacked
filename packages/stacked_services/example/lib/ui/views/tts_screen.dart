import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TtsScreen extends StatelessWidget {
  const TtsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IMPLEMENTATION NOTE: Services should never be used directly in a view refer to
    // https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/#how-does-stacked-work
    // for more details.
    TtsService _ttsService = locator<TtsService>();
    TextEditingController _editingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Text-To-Speech Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "This screen showcases Text-To-Speech Service functionality :)",
              softWrap: true,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            OutlineButton(
              child: Text("This button says hello when pressed!"),
              onPressed: () async {
                await _ttsService.speak(
                  text: 'hello',
                );
              },
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  labelText: 'Enter Text to Say!',
                ),
              ),
            ),
            OutlineButton(
              child: Text("Say what is in the field above!"),
              onPressed: () async {
                await _ttsService.speak(
                  text: _editingController.text == ''
                      ? 'please enter some text'
                      : _editingController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

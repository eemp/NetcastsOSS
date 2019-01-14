import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/widgets/home.dart';
import 'package:hear2learn/redux/reducer.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final Store<AppState> store = new Store<AppState>(
    AppReducer,
    initialState: AppState(),
  );

  App app = new App();
  await app.init(store);

  runApp(
    AppWidget(
      store: store,
      title: 'Hear2Learn',
    )
  );
}

class AppWidget extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  AppWidget({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        accentColor: Colors.pink[700],
        brightness: brightness,
        fontFamily: 'OpenSans',
        primaryColor: Colors.blueGrey[500],
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      ),
      themedWidgetBuilder: (context, theme) {
        return StoreProvider<AppState>(
          store: store,
          child: MaterialApp(
            title: title,
            home: Home(),
            theme: theme,
          ),
        );
      },
    );
  }
}

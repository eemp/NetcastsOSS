import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/dynamic_theme.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/themes.dart';
import 'package:hear2learn/widgets/home/index.dart';
import 'package:redux/redux.dart';

Future<void> start({ List<NavigatorObserver> navigatorObservers }) async {
  final App app = App();

  app.store.dispatch(updateConnectivity);
  app.store.dispatch(loadSettings);
  app.store.dispatch(updateSubscriptions);
  app.store.dispatch(updateDownloads);

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);

  navigatorObservers ??= <NavigatorObserver>[];
  runApp(
    AppWidget(
      navigatorObservers: navigatorObservers,
      store: app.store,
      title: app.packageInfo.appName,
    )
  );
}

class AppWidget extends StatelessWidget {
  final List<NavigatorObserver> navigatorObservers;
  final Store<AppState> store;
  final String title;

  const AppWidget({
    Key key,
    this.navigatorObservers,
    this.store,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultThemeName: ThemeProvider.DEFAULT_THEME,
      themeBuilder: ThemeProvider(),
      widgetBuilder: (BuildContext context, ThemeData theme) {
        return StoreProvider<AppState>(
          store: store,
          child: MaterialApp(
            home: Home(),
            navigatorObservers: navigatorObservers,
            theme: theme,
            title: title,
          ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/helpers/podcast.dart';
import 'package:hear2learn/models/podcast.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/reducer.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/themes.dart';
import 'package:hear2learn/widgets/home.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final Store<AppState> store = new Store<AppState>(
    AppReducer,
    initialState: AppState(),
    middleware: [
      thunkMiddleware,
    ],
  );

  App app = new App();
  await app.init(store);

  List<Podcast> subscriptions = await getSubscriptions();
  store.dispatch(Action(
    type: ActionType.UPDATE_SUBSCRIPTIONS,
    payload: {
      'subscriptions': subscriptions,
    },
  ));

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

  AppWidget({
    Key key,
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
            title: title,
            home: Home(),
            theme: theme,
          ),
        );
      },
    );
  }
}

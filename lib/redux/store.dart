import 'package:hear2learn/redux/reducer.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final Store<AppState> store = Store<AppState>(
  AppReducer,
  initialState: const AppState(),
  // ignore: always_specify_types
  middleware: [
    thunkMiddleware,
  ],
);

Store<AppState> appStore() {
  return store;
}

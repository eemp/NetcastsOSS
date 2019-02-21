import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/models/app_settings.dart';
import 'package:hear2learn/themes.dart';
import 'package:hear2learn/widgets/common/bottom_app_bar_player.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';

class Settings extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final App app = App();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: StoreConnector<AppState, AppSettings>(
        converter: settingsSelector,
        builder: (BuildContext context, AppSettings settings) {
          return Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('${app.packageInfo.packageName}@${app.packageInfo.version}.${app.packageInfo.buildNumber}', style: Theme.of(context).textTheme.overline),
                      Text('${app.packageInfo.appName}', style: Theme.of(context).textTheme.headline),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                const Divider(),
                Container(
                  child: InputDecorator(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        items: ThemeProvider.THEME_LIST.map((String theme) => DropdownMenuItem<String>(
                          child: Text(theme),
                          value: theme,
                        )).toList(),
                        onChanged: (String themeName) {
                          app.store.dispatch(
                            updateSettings(context, settings.copyWith(
                              themeName: themeName,
                            ))
                          );
                        },
                        value: settings.themeName,
                      ),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.color_lens),
                      labelText: 'Theme',
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  subtitle: const Text('Toggle this on if you want to limit your data usage'),
                  title: const Text('Wi-Fi Only Downloads'),
                  trailing: Checkbox(
                    onChanged: (bool wifiSetting) {
                      app.store.dispatch(
                        updateSettings(context, settings.copyWith(
                          wifiSetting: wifiSetting,
                        ))
                      );
                    },
                    value: settings.wifiSetting,
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  subtitle: const Text('Cut out dead moments in episodes'),
                  title: const Text('Skip Silence'),
                  trailing: Checkbox(
                    onChanged: (bool skipSilence) {
                      app.store.dispatch(
                        updateSettings(context, settings.copyWith(
                          skipSilence: skipSilence,
                        ))
                      );
                    },
                    value: settings.skipSilence,
                  ),
                ),
                Container(
                  child: InputDecorator(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<double>(
                        isDense: true,
                        items: <double>[0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3].map((double speed) => DropdownMenuItem<double>(
                          child: Text(speed.toString()),
                          value: speed,
                        )).toList(),
                        onChanged: (double speed) {
                          app.store.dispatch(
                            updateSettings(context, settings.copyWith(
                              speed: speed,
                            ))
                          );
                        },
                        value: settings.speed ?? 1.0,
                      ),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.play_arrow),
                      labelText: 'Player Speed',
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  subtitle: const Text('Help improve the app'),
                  title: const Text('Share Usage Information'),
                  trailing: Checkbox(
                    onChanged: (bool privacySetting) {
                      app.store.dispatch(
                        updateSettings(context, settings.copyWith(
                          privacySetting: privacySetting,
                        ))
                      );
                    },
                    value: settings.privacySetting,
                  ),
                ),
              ],
              padding: const EdgeInsets.all(16.0),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomAppBarPlayer(),
    );
  }
}

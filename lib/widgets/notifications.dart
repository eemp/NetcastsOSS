import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:hear2learn/widgets/settings/index.dart';

void showNoConnectivityNotification(BuildContext context) {
  if(context == null) {
    return;
  }

  // ignore: always_specify_types
  Flushbar()
    ..backgroundColor = Theme.of(context).accentColor
    ..titleText = Text('No Connectivity', style: Theme.of(context).accentTextTheme.title)
    ..messageText = Text('Please try again later when connectivity is available to download episodes', style: Theme.of(context).accentTextTheme.body1)
    ..duration = const Duration(seconds: 3)
    ..show(context);
}

void showNoWifiNotification(BuildContext context) {
  if(context == null) {
    return;
  }

  // ignore: always_specify_types
  Flushbar()
    ..backgroundColor = Theme.of(context).accentColor
    ..titleText = Text('Wifi Unavailable', style: Theme.of(context).accentTextTheme.title)
    ..messageText = Text('Please try again later or update app settings to download without wifi', style: Theme.of(context).accentTextTheme.body1)
    ..mainButton = FlatButton(
      child: Text('Settings', style: Theme.of(context).accentTextTheme.button),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Settings(),
            settings: const RouteSettings(name: Settings.routeName),
          ),
        );
      }
    )
    ..duration = const Duration(seconds: 4)
    ..show(context);
}

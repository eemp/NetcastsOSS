import 'package:dart_chromecast/casting/cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hear2learn/app.dart';
import 'package:hear2learn/redux/actions.dart';
import 'package:hear2learn/redux/selectors.dart';
import 'package:hear2learn/redux/state.dart';
import 'package:hear2learn/widgets/common/chromecast_device_picker.dart';

class EnhancedAppBar extends StatelessWidget with PreferredSizeWidget {
  final App app = App();
  final PreferredSizeWidget bottom;
  final Widget title;

  EnhancedAppBar({
    Key key,
    this.bottom,
    this.title,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      bottom: bottom,
      actions: <Widget>[
        StoreConnector<AppState, CastSender> (
          converter: castSelector,
          builder: (BuildContext context, CastSender cast) {
            bool connected = cast != null;
            return IconButton(
              icon: Icon(connected ? Icons.cast_connected : Icons.cast),
              onPressed: () async {
                if(connected) {
                  await app.store.dispatch(disconnectCast());
                  return;
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DevicePicker(
                      onDevicePicked: (CastDevice cast) async {
                        await app.store.dispatch(connectToCast(cast));
                      },
                    ),
                    fullscreenDialog: true,
                  )
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0));
}

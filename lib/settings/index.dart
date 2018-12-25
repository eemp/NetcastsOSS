import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import 'package:hear2learn/common/vertical_list_view.dart';
import 'package:hear2learn/common/with_fade_in_image.dart';
import 'package:hear2learn/podcast/index.dart';

const MAX_SHOWCASE_LIST_SIZE = 20;
var podcastApiService = new PodcastApi();

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  final formKey = new GlobalKey<FormState>();
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> themes = [ 'Dark', 'Light' ];
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            InputDecorator(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  items: themes.map((String theme) => DropdownMenuItem<String>(
                    child: Text(theme),
                    value: theme,
                  )).toList(),
                  onChanged: (String newTheme) {},
                  value: 'Light',
                ),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.color_lens),
                labelText: 'Theme',
              ),
            ),
          ],
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: ListTile(
            title: const Text('Chuck Nice'),
            subtitle: const Text('Host'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/3/35/Chuck_Nice_at_Caroline%27s.jpg'),
            ),
          ),
        ),
        Container(
          child: ListTile(
            title: const Text('Neil deGrasse Tyson'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Neil_deGrasse_Tyson_in_June_2017_%28cropped%29.jpg/800px-Neil_deGrasse_Tyson_in_June_2017_%28cropped%29.jpg'),
            ),
          ),
        ),
      ],
      shrinkWrap: true,
    );
  }
}


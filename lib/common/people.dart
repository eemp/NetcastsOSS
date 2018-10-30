import 'package:flutter/material.dart';

class PeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: ListTile(
            title: Text('Neil deGrasse Tyson'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Neil_deGrasse_Tyson_in_June_2017_%28cropped%29.jpg/800px-Neil_deGrasse_Tyson_in_June_2017_%28cropped%29.jpg'),
            ),
          ),
        ),
        Container(
          child: ListTile(
            title: Text('Chuck Nice'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/3/35/Chuck_Nice_at_Caroline%27s.jpg'),
            ),
          ),
        ),
      ],
      shrinkWrap: true,
    );
  }
}


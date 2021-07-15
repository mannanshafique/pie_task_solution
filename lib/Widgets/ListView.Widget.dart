import 'package:flutter/material.dart';
import 'dart:math';

class ListViewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final  onTapFunction;

  ListViewWidget(this.title, this.subtitle, this.time, this.onTapFunction);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: onTapFunction,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
        ),
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Text('${title[0].toUpperCase()}',
              style: TextStyle(color: Colors.white)),
        ),
        trailing: Text(time, style: TextStyle(fontSize: 13)),
      ),
    );
  }
}

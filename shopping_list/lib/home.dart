import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
          Image.asset('assets/rush.jpg'),
          Text('My one and only love')
        ],),);
  }
}
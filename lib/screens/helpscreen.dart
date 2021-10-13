import 'package:flutter/material.dart';

class Helpscreen extends StatelessWidget{
  static const routename = '/helpscreen';
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Help',style: TextStyle(color: Colors.black),),
          iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: Container(
            child: Text('NOT AVAILABLE YET !!!'),
          ),
        ),
      );
  }
}
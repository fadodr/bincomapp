import 'package:bincomapp/widget/hextocolor.dart';
import 'package:flutter/material.dart';

class Profilescreen extends StatelessWidget {
  static const routename = '/profilescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile',style: TextStyle(color: Colors.black),),
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
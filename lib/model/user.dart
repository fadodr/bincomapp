import 'package:flutter/cupertino.dart';

class User {
  final String? fullname;
  final String? email;
  final String? phonenumber;
  final String? password;

  User({
    @required this.fullname,
    @required this.email,
    @required this.phonenumber,
    this.password
  });
}
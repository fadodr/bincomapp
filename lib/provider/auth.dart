import 'dart:async';
import 'package:bincomapp/model/httpexception.dart';
import 'package:bincomapp/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class Auth extends ChangeNotifier {
  String? token;
  DateTime? expiryDate;
  String? userId;
  Timer? authTimer;
  
  bool get isAuth {
    return gettoken != null;
  }

  String? get gettoken {
    if(expiryDate != null && expiryDate!.isAfter(DateTime.now()) && token != null){
      return token;
    }
    return null;
  }
  String? get getuserId {
    if(userId != null){
      return userId!;
    }
    return null;
  }


  Future<void> signup(User _user) async {
    var url ='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDg1VLL7-EliDQa14eWeKlw7Dkc16cA0DY';

    try {
      final response = await http.post(Uri.parse(url), body: json.encode({ 'email' : _user.email, 'password' : _user.password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
    url = 'https://fadowebsite-default-rtdb.firebaseio.com/users.json';
    await http.post(Uri.parse(url), body: json.encode({'userid': responseData['localId'], 'fullname': _user.fullname, 'email' : _user.email, 'phonenumber':_user.phonenumber}));
    token = responseData['idToken'];
    userId = responseData['localId'];
    expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseData['expiresIn'])
      )
    );
    notifyListeners();
    }catch(error){
      throw error;
    }
    return;
  }

  Future<void> login (User _user) async {
    var url ='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDg1VLL7-EliDQa14eWeKlw7Dkc16cA0DY';
    try{
      final response = await http.post(Uri.parse(url), body: json.encode({ 'email' : _user.email, 'password' : _user.password, 'returnSecureToken': true}));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
          throw HttpException(responseData['error']['message']);
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn'])
        )
      );
      tryautologout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token' : token,
        'userid' : userId,
        'expiry_date' : expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    }
    catch(error){
      throw error;
    }
    return;
  }

  Future<void> logout() async {
    token = null;
    userId = null;
    expiryDate = null;
    if(authTimer != null){
      authTimer!.cancel();
      authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void tryautologout() {
    if(authTimer != null){
      authTimer!.cancel();
    }
    final timeToExpiry = expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<bool> tryautologin() async {
      final prefs = await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')){
        return false;
      }
      final extractedUserData = json.decode(prefs.getString('userData')!) as  Map<String, dynamic>;
      final _expiryDate = DateTime.parse(extractedUserData['expiry_date']);
      if(_expiryDate.isBefore(DateTime.now())){
        return false;
      }
      token = extractedUserData['token'];
      userId = extractedUserData['userid'];
      expiryDate = DateTime.parse(extractedUserData['expiry_date']);
      notifyListeners();
      tryautologout();
      return true;
  }
}
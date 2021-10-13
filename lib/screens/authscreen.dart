import 'package:bincomapp/model/httpexception.dart';
import 'package:bincomapp/model/user.dart';
import 'package:bincomapp/provider/auth.dart';
import 'package:bincomapp/screens/dashboardscreen.dart';
import 'package:bincomapp/widget/hextocolor.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

enum AuthMode { Signup, Login}

class Authscren extends StatefulWidget{
  static const routename = '/authscreen';
  @override
  _AuthscrenState createState() => _AuthscrenState();
}

class _AuthscrenState extends State<Authscren> {
  AuthMode _authmode = AuthMode.Login;
  final _form = GlobalKey<FormState>();
  TextEditingController _confirmpassword = TextEditingController();
  var _user = User(
    fullname: '',
    email: '',
    phonenumber: '',
    password: ''
  );
  bool isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('close'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  Future<void> _submit() async {
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try{
      if(_authmode == AuthMode.Signup){
      await Provider.of<Auth>(context, listen: false).signup(_user);
    }
    else{
      await Provider.of<Auth>(context, listen: false).login(_user);
    }
    } on HttpException catch(error){
        final _errormessage = error.message;
        _showErrorDialog(_errormessage);
    }
    catch(error){
       const _errormessage = 'there was an error, try again later';
       _showErrorDialog(_errormessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _chageauthode(){
    if( _authmode == AuthMode.Signup){
      setState(() {
        _authmode = AuthMode.Login;
      });
    }
    else{
      setState(() {
      _authmode = AuthMode.Signup;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                          transform: Matrix4.rotationZ(-8 * pi / 180)
                            ..translate(-10.0),
                          // ..translate(-10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellow.shade500,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                child: Text('Welcome', 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Form(
                      key: _form,
                      child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if(_authmode == AuthMode.Signup)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Full name'),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'field cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onSaved: (value){
                              _user = User(
                                fullname: value,
                                email: _user.email,
                                phonenumber: _user.phonenumber,
                                password: _user.password
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'E-mail'),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'field cannot be empty';
                              }
                              if(!(value.contains('@') && value.contains('.com'))){
                                return 'please enter a valid email address';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onSaved: (value){
                              _user = User(
                                fullname: _user.fullname,
                                email: value,
                                phonenumber: _user.phonenumber,
                                password: _user.password
                              );
                            },
                          ),
                          if(_authmode == AuthMode.Signup)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Phone number'),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'field cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onSaved: (value){
                              _user = User(
                                fullname: _user.fullname,
                                email: _user.email,
                                phonenumber: value,
                                password: _user.password
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'field cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onSaved: (value){
                              _user = User(
                                fullname: _user.fullname,
                                email: _user.email,
                                phonenumber: _user.phonenumber,
                                password: value
                              );
                            },
                          ),
                          if(_authmode == AuthMode.Signup)
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Confirm password'),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'field cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: _submit, child: isLoading ? CircularProgressIndicator(color: Colors.black) : Text( _authmode == AuthMode.Signup ? 'Sign up' : 'Login', style: TextStyle(color: Colors.black),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_authmode == AuthMode.Signup ? 'do you have an account ?' : 'don\'t have an account ?'),
                              TextButton(onPressed: _chageauthode, child: Text(_authmode == AuthMode.Signup ? 'login' : 'signup', style: TextStyle(color: hextocolor('#f7be00')),))
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
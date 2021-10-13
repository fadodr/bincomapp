import 'package:bincomapp/provider/Incidentreportsprovider.dart';
import 'package:bincomapp/provider/auth.dart';
import 'package:bincomapp/screens/addincidentscreen.dart';
import 'package:bincomapp/screens/dashboardscreen.dart';
import 'package:bincomapp/screens/helpscreen.dart';
import 'package:bincomapp/screens/previousincident.dart';
import 'package:bincomapp/screens/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/authscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, IncidentreporterProvider>(
          create: (ctx) => IncidentreporterProvider(),
          update: (ctx, auth, data) => data!..update(auth.gettoken == null ? '' : auth.gettoken!, auth.getuserId== null ? '' : auth.getuserId!))
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          home: auth.isAuth ? Dashboardscreen() : FutureBuilder(
            future: auth.tryautologin(),
            builder: (ctx, authresult) => authresult.connectionState == ConnectionState.waiting 
            ? Scaffold(body: CircularProgressIndicator(),) : Authscren()),
          routes:  {
            Addincidentscreen.routename : (ctx) => Addincidentscreen(),
            Authscren.routename : (ctx) => Authscren(),
            Dashboardscreen.routename : (ctx) => Dashboardscreen(),
            Helpscreen.routename : (ctx) => Helpscreen(),
            Previousincidentscreen.routename : (ctx) => Previousincidentscreen(),
            Profilescreen.routename : (ctx) => Profilescreen(),
         },
        )),
    );
  }
}

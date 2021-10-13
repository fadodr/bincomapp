import 'package:bincomapp/model/dashboarditems.dart';
import 'package:bincomapp/provider/Incidentreportsprovider.dart';
import 'package:bincomapp/provider/auth.dart';
import 'package:bincomapp/screens/addincidentscreen.dart';
import 'package:bincomapp/screens/helpscreen.dart';
import 'package:bincomapp/screens/previousincident.dart';
import 'package:bincomapp/screens/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboardscreen extends StatelessWidget{
  static const routename = '/dashboardscreen';
  @override
  Widget build(BuildContext context) {
    Provider.of<IncidentreporterProvider>(context, listen: false).fetchincidents();
    final List<Dashboard> _griditems = [
        Dashboard('REPORT AN INCIDENT', Icons.alarm_add_outlined, Addincidentscreen.routename ),
        Dashboard('PREVIOUS INCIDENT', Icons.alarm_sharp, Previousincidentscreen.routename),
        Dashboard('MY PROFILE', Icons.account_circle_rounded, Profilescreen.routename),
        Dashboard('HELP', Icons.help_outline, Helpscreen.routename)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              Provider.of<Auth>(context , listen: false).logout();
            },
            child: Row(
              children: [
                Text('Logout', style: TextStyle(
                  color: Colors.black
                ),),
                Icon(Icons.logout, color: Colors.black,)
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow
            ),
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.asset('assets/images/incidentlogo.png', fit: BoxFit.scaleDown,
            height: 100,width: 100,)
          ),
          Expanded(
            child: Container(
             child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  ),
              itemCount: _griditems.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(_griditems[index].route),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(_griditems[index].icon, size: 32,),
                        Text(_griditems[index].name, style: TextStyle(
                          fontSize: 16
                        ),)
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(color: Colors.black, width: 0.5)
                    ),
                  ),
                );
              }),
          
              ),
          ),
        ],
      ),
    );
  }
}
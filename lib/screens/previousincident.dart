import 'package:bincomapp/model/incidentreport.dart';
import 'package:bincomapp/provider/Incidentreportsprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Previousincidentscreen extends StatelessWidget {
  static const routename = '/previousincident';
  @override
  Widget build(BuildContext context) {
    List<Incident> _incidentslist = Provider.of<IncidentreporterProvider>(context).getincidents;
     return Scaffold(
       appBar: AppBar(
         title: Text('Previous incidents', style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow,
       ),
       body: ListView.builder(
         itemCount: _incidentslist.length,
         itemBuilder: (ctx, index) => _incidentslist.length == 0 ? Center(
          child: Container(
            child: Text('NO INCIDENT REPORT AVAILABLE YET'),
          ),
        ) :   ListTile(
             leading: Icon(Icons.alarm_on_rounded),
             title: Text(_incidentslist[index].victimName.toString()),
             trailing: Icon(Icons.done),
             subtitle: Text(_incidentslist[index].descriptionIncident.toString()),
              onTap: (){}
           ) 
         ),
     );
  }
}
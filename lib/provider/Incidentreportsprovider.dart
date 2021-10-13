import 'dart:convert';

import 'package:bincomapp/model/incidentreport.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class IncidentreporterProvider extends ChangeNotifier {
  List<Incident> _incidents = [];
  String? userId;
  String? token;


  List<Incident> get getincidents {
    return [..._incidents];
  }

  void update(String authtoken, String userid){
    token = authtoken;
    userId = userid;
  }

  Future<void> addincident(Incident incident) async {
    final dateTime = DateTime.now().toIso8601String();
    final url = 'https://fadowebsite-default-rtdb.firebaseio.com/incidents.json';
    try{
      await http.post(Uri.parse(url), body: json.encode({
        'creator_id' : userId,
        'reporter_name' : incident.reporterName,
        'victim_name' : incident.victimName,
        'victim_address' : incident.victimAddress,
        'victim_number' : incident.victimPhoneNumber,
        'reporter_number' : incident.repoterPhoneNumber,
        'victim_gender' : incident.victimGender,
        'reporter_gender' : incident.reporterGender,
        'report_date' : dateTime,
        'incident_description' : incident.descriptionIncident,
        'additional_info' : incident.additionalInfo
    }));
    final newincident = Incident(
      reporterName: incident.reporterName,
      victimName: incident.victimName,
      victimAddress: incident.victimAddress,
      victimPhoneNumber: incident.victimPhoneNumber,
      repoterPhoneNumber: incident.repoterPhoneNumber,
      victimGender: incident.victimGender,
      reporterGender: incident.reporterGender,
      reportDate: DateTime.parse(dateTime),
      descriptionIncident: incident.descriptionIncident,
      additionalInfo: incident.additionalInfo
    );

    _incidents.add(newincident);
    notifyListeners();
    }
    catch(error){
      throw error;
    }
  }


  Future<void> fetchincidents() async {
    final url = 'https://fadowebsite-default-rtdb.firebaseio.com/incidents.json?';
    try{
      final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final List<Incident> loadedincident = [];
    responseData.forEach((incidentId, incidentData) { 
      loadedincident.add(Incident(
          reporterName: incidentData['reporter_name'],
          victimName: incidentData['victim_name'],
          victimAddress: incidentData['victim_address'],
          victimPhoneNumber: incidentData['victim_number'],
          repoterPhoneNumber: incidentData['repoter_number'],
          victimGender: incidentData['victim_gender'],
          reporterGender: incidentData['reporter_gender'],
          reportDate: DateTime.parse(incidentData['report_date']),
          descriptionIncident: incidentData['incident_description'],
          additionalInfo: incidentData['additional_info']
      ));
    });
    _incidents = loadedincident;
    notifyListeners();
    }
    catch(error){
      throw error;
    }
  }
}
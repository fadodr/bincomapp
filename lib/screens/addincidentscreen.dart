import 'package:bincomapp/model/httpexception.dart';
import 'package:bincomapp/model/incidentreport.dart';
import 'package:bincomapp/provider/Incidentreportsprovider.dart';
import 'package:bincomapp/widget/hextocolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addincidentscreen extends StatefulWidget {
  static const routename = '/addincicdent';
  @override
  _AddincidentscreenState createState() => _AddincidentscreenState();
}

class _AddincidentscreenState extends State<Addincidentscreen> {
  int _victimgender = -1;
  int _reportergender = -1;
  final _form = GlobalKey<FormState>();
  Map<String, dynamic> _radioinput = {
    '0' : 'male',
    '1' : 'female',
    '-1' : null
  };
  bool isLoading = false;
  Incident _incident = Incident(
    reporterName: '',
    victimName: '',
    victimAddress: '',
    victimPhoneNumber: '',
    repoterPhoneNumber: '',
    victimGender: '',
    reporterGender: '',
    descriptionIncident: '',
    additionalInfo: ''
  );
  InputDecoration _inpudecoration(String label) {
    return InputDecoration(
        labelStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        labelText: label,
        hintText: label,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 2, color: Colors.red)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 2, color: hextocolor('#d0d6d1'))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: hextocolor('#d0d6d1'))));
  }

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

  Future<void> submit() async {
    final isValid = _form.currentState!.validate();
    if(!isValid){
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<IncidentreporterProvider>(context, listen: false).addincident(_incident);
      showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Incident report suucessfully submitted'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
    _form.currentState!.reset();
    setState(() {
      _victimgender = -1;
       _reportergender = -1;
    });
    }
    catch(error){
      const errorMessage = 'An error occurred, please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report an incident', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: _inpudecoration('Name of reporter'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
                onSaved: (value){
                  _incident = Incident(
                    reporterName: value,
                    victimName: _incident.victimName,
                    victimAddress: _incident.victimAddress,
                    victimPhoneNumber: _incident.victimPhoneNumber,
                    repoterPhoneNumber: _incident.repoterPhoneNumber,
                    victimGender: _incident.victimGender,
                    reporterGender: _incident.reporterGender,
                    descriptionIncident: _incident.descriptionIncident,
                    additionalInfo: _incident.additionalInfo
                  );
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: _inpudecoration('Name of victim'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
                onSaved: (value){
                  _incident = Incident(
                    reporterName: _incident.reporterName,
                    victimName: value,
                    victimAddress: _incident.victimAddress,
                    victimPhoneNumber: _incident.victimPhoneNumber,
                    repoterPhoneNumber: _incident.repoterPhoneNumber,
                    victimGender: _incident.victimGender,
                    reporterGender: _incident.reporterGender,
                    descriptionIncident: _incident.descriptionIncident,
                    additionalInfo: _incident.additionalInfo
                  );
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: _inpudecoration('Address of victim'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
                onSaved: (value){
                  _incident = Incident(
                    reporterName: _incident.reporterName,
                    victimName: _incident.victimName,
                    victimAddress: value,
                    victimPhoneNumber: _incident.victimPhoneNumber,
                    repoterPhoneNumber: _incident.repoterPhoneNumber,
                    victimGender: _incident.victimGender,
                    reporterGender: _incident.reporterGender,
                    descriptionIncident: _incident.descriptionIncident,
                    additionalInfo: _incident.additionalInfo
                  );
                },
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                      Expanded(
                        child: 
                        TextFormField(
                          decoration: _inpudecoration('Victim\'s phone number'),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'field cannot be empty';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _incident = Incident(
                              reporterName: _incident.reporterName,
                              victimName: _incident.victimName,
                              victimAddress: _incident.victimAddress,
                              victimPhoneNumber: value,
                              repoterPhoneNumber: _incident.repoterPhoneNumber,
                              victimGender: _incident.victimGender,
                              reporterGender: _incident.reporterGender,
                              descriptionIncident: _incident.descriptionIncident,
                              additionalInfo: _incident.additionalInfo
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                  Expanded(
                    child: 
                    TextFormField(
                      decoration: _inpudecoration('Reporters\'s phone number'),
                      validator: (value){
                      if(value!.isEmpty){
                        return 'field cannot be empty';
                      }
                      return null;
                    },
                      onSaved: (value){
                        _incident = Incident(
                          reporterName: _incident.reporterName,
                          victimName: _incident.victimName,
                          victimAddress: _incident.victimAddress,
                          victimPhoneNumber: _incident.victimPhoneNumber,
                          repoterPhoneNumber: value,
                          victimGender: _incident.victimGender,
                          reporterGender: _incident.reporterGender,
                          descriptionIncident: _incident.descriptionIncident,
                          additionalInfo: _incident.additionalInfo
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sex of victim'),
                        Row(
                          children: [
                            Radio(value: 0, groupValue: _victimgender, onChanged: (value){
                              setState(() {
                                _victimgender = int.parse(value.toString());
                                _incident = Incident(
                                  reporterName: _incident.reporterName,
                                  victimName: _incident.victimName,
                                  victimAddress: _incident.victimAddress,
                                  victimPhoneNumber: _incident.victimPhoneNumber,
                                  repoterPhoneNumber: _incident.repoterPhoneNumber,
                                  victimGender: _radioinput[value.toString()],
                                  reporterGender: _incident.reporterGender,
                                  descriptionIncident: _incident.descriptionIncident,
                                  additionalInfo: _incident.additionalInfo
                                );
                              });
                            }),
                            Text('Male')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: 1, groupValue: _victimgender, onChanged: (value){
                              setState(() {
                                _victimgender = int.parse(value.toString());
                                _incident = Incident(
                                  reporterName: _incident.reporterName,
                                  victimName: _incident.victimName,
                                  victimAddress: _incident.victimAddress,
                                  victimPhoneNumber: _incident.victimPhoneNumber,
                                  repoterPhoneNumber: _incident.repoterPhoneNumber,
                                  victimGender: _radioinput[value.toString()],
                                  reporterGender: _incident.reporterGender,
                                  descriptionIncident: _incident.descriptionIncident,
                                  additionalInfo: _incident.additionalInfo
                                );
                              });
                            }),
                            Text('Female')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sex of reporter'),
                        Row(
                          children: [
                            Radio(value: 0, groupValue: _reportergender, onChanged: (value){
                              setState(() {
                               _reportergender = int.parse(value.toString());
                               _incident = Incident(
                                  reporterName: _incident.reporterName,
                                  victimName: _incident.victimName,
                                  victimAddress: _incident.victimAddress,
                                  victimPhoneNumber: _incident.victimPhoneNumber,
                                  repoterPhoneNumber: _incident.repoterPhoneNumber,
                                  victimGender: _incident.victimGender,
                                  reporterGender: _radioinput[value.toString()],
                                  descriptionIncident: _incident.descriptionIncident,
                                  additionalInfo: _incident.additionalInfo
                                );
                              });
                            }),
                            Text('Male')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: 1, groupValue: _reportergender, onChanged: (value){
                              setState(() {
                                _reportergender = int.parse(value.toString());
                                _incident = Incident(
                                  reporterName: _incident.reporterName,
                                  victimName: _incident.victimName,
                                  victimAddress: _incident.victimAddress,
                                  victimPhoneNumber: _incident.victimPhoneNumber,
                                  repoterPhoneNumber: _incident.repoterPhoneNumber,
                                  victimGender: _incident.victimGender,
                                  reporterGender: _radioinput[value.toString()],
                                  descriptionIncident: _incident.descriptionIncident,
                                  additionalInfo: _incident.additionalInfo
                                );
                              });
                            }),
                            Text('Female')
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
               TextFormField(
                decoration: _inpudecoration('Description of incident'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onSaved: (value){
                  _incident = Incident(
                    reporterName: _incident.reporterName,
                    victimName: _incident.victimName,
                    victimAddress: _incident.victimAddress,
                    victimPhoneNumber: _incident.victimPhoneNumber,
                    repoterPhoneNumber: _incident.repoterPhoneNumber,
                    victimGender: _incident.victimGender,
                    reporterGender: _incident.reporterGender,
                    descriptionIncident:value,
                    additionalInfo: _incident.additionalInfo
                  );
                },
              ),
              SizedBox(height: 15,),
               TextFormField(
                decoration: _inpudecoration('Addition information'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'field cannot be empty';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onSaved: (value){
                  _incident = Incident(
                    reporterName: _incident.reporterName,
                    victimName: _incident.victimName,
                    victimAddress: _incident.victimAddress,
                    victimPhoneNumber: _incident.victimPhoneNumber,
                    repoterPhoneNumber: _incident.repoterPhoneNumber,
                    victimGender: _incident.victimGender,
                    reporterGender: _incident.reporterGender,
                    descriptionIncident: _incident.descriptionIncident,
                    additionalInfo: value
                  );
                },
              ),
              SizedBox(height: 8,),
              ElevatedButton(
                onPressed: submit, 
                child: isLoading ? CircularProgressIndicator(color: Colors.black,) : Text('Submit', style: TextStyle(color: Colors.black),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)
                ),
                )
            ],
          ),
        )),
      ),
    );
  }
}
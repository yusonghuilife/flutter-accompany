import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiagnosisInfo extends StatefulWidget{
  DiagnosisInfo({Key key,this.id}): super(key:key);
  final String id;
  @override
  _DiagnosisInfoState createState() => _DiagnosisInfoState();

}

class _DiagnosisInfoState extends State<DiagnosisInfo> {
  var info = [];
  _getRecordListOneWeek() async{
    var url = 'http://172.20.10.4:8000/appointments/appointment_info_list/?doctor_id=${widget.id}';
    var response = await http.get(url);

    setState(() {
      info = json.decode(response.body);
    });
    return response;

  }

  _getRecordListReserved() async{
    var url = 'http://172.20.10.4:8000/appointments/appointment_only_list/?doctor_id=${widget.id}';
    var response = await http.get(url);

    setState(() {
      info = json.decode(response.body);
    });
    return response;

  }
  Color color = Colors.white;
  Color clickColor = Colors.blue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get list from back-end
    _getRecordListOneWeek();
    //info remove duplicated
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
//            padding: EdgeInsets.only(top: 30),
            margin: EdgeInsets.only(top: 100),
            child: ListView.builder(
                itemCount: info.length,
                itemBuilder: (context,index) {
                  return PersonListItem(
                      name: info[index]['patient']['name'],
                      msg: info[index]['appointment_state'],
                      dateTime: info[index]['appointment_time'],
                      route: 'PatientReserve',
                      id: info[index]['patient']['patient_id'],
                      doctorId: info[index]['doctor']['doctor_id'],
                      guardianId: info[index]['guardian']['guardian_id'],
//                      reserveId:info[]

                  );
                },

            ),
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(top: 45),
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '就诊信息',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10),
                        height: 25,
                        decoration: new BoxDecoration(
                          color: clickColor,
                          border: new Border.all(width: 1.0, color: Colors.blue),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(6))
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              color = Colors.white;
                              clickColor = Colors.blue;
                              info = [];
                              _getRecordListOneWeek();
                            });
                          },
                          child: Text(
                            '一周内记录',
                            style: TextStyle(
                                fontSize: 13,
                                color: color,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10),
                        height: 25,
                        decoration: new BoxDecoration(
                            color: color,
                            border: new Border.all(width: 1.0, color: Colors.blue),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(6))
                        ),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              color = Colors.blue;
                              clickColor = Colors.white;
                              info = [];
                              _getRecordListReserved();
                            });

                          },
                          child: Text(
                              '就诊预约',
                            style: TextStyle(
                              fontSize: 13,
                              color: clickColor,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }

}
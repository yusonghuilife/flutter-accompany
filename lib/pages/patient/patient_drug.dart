import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/pages/patient/reserveInfo.dart';
import 'package:trip/pages/patient/doctor_appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PatientDrug extends StatefulWidget{
  PatientDrug({Key key,this.patientId,this.name,this.gender,this.age,this.tel}) :super(key: key);
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _PatientDrug createState() {
    // TODO: implement createState
    return _PatientDrug();
  }

}

class _PatientDrug extends State<PatientDrug>{
  var info = {};
  _getPatientDrugInfo() async{
    var url = 'http://172.20.10.4:8000/treatships/get_one_treatment_info/?patient_id=${widget.patientId}';
    var response = await http.get(url);

    setState(() {
      info = {};
      info = json.decode(response.body);
//      print(response.body);
    });
    return response;

  }


  @override
  void initState() {
    _getPatientDrugInfo();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text('医嘱',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          DividerDrug(
            color: Color(0xffB4D7D2),
          ),
          MultiLineInfo(
            name: '',
            hintText: info['medicine'],
            enable: false,
          ),
          DividerWithColor(text: '注意事项',color: Color(0xffB4D7D2),),
          OneLineInfo(name: '现今病情',hintText: info['illness_now'],enable: false,),
          MultiLineInfo(
            name: '以往病史',
            hintText: info['illness_past'],
            enable: false,
          ),
          OneLineInfo(name: '复诊时间',hintText: info['sub_visit_time'],enable: false,),
          MultiLineInfo(
            name:'治疗方案',
            hintText: info['treatment'],
            enable: false,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 30),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CupertinoButton(
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context){return new ReserveInfo(guardianId:info['guardian'],patientId:widget.patientId,name: widget.name,gender: widget.gender,age: widget.age,tel: widget.tel,);}));
                  },
                  color: Colors.blue,
                  pressedOpacity: 0.8,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text('查看预约',style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
                CupertinoButton(
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context){return new DoctorAppointment(doctorId:info['doctor'],patientId: info['patient'],guardianId: info['guardian'],name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel);}));
                  },
                  color: Colors.blue,
                  pressedOpacity: 0.8,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text('就诊预约',style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}

class DividerDrug extends StatelessWidget{
  DividerDrug({Key key,this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 46,
      color: color,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              '用药信息',
              style: TextStyle(
                  color: Color(0xFF659791),
                  fontSize: 15
              ),
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text('设置用药提醒',style: TextStyle(color: Color(0xFF659791)),),
                onPressed: (){
                  //原生闹铃
                },
              ),

              Icon(
                Icons.access_alarm,
                color: Color(0xFF659791),
                size: 30.0,
              )
            ],
          )
        ],
      )
    );
  }
}
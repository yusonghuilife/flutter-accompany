import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/navigator/patient_tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trip/pages/patient/noReservePage.dart';
import 'package:dio/dio.dart';
class ReserveInfo extends StatefulWidget{
  ReserveInfo({Key key,this.guardianId,this.patientId,this.name,this.gender,this.age,this.tel}):super(key : key);
  final String guardianId;
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _ReserveInfo createState() {
    // TODO: implement createState
    return _ReserveInfo();
  }

}

class _ReserveInfo extends State<ReserveInfo> {
  var info = {};
  var name = '';
  var gender = '';
  var age = '';
  var appointmentTime = '';
  var phoneNumber = '';
  var id = '';
  _getReserveInfo() async{
    var url = 'http://172.20.10.4:8000/appointments/guardian_get_appoint/?guardian_id=${widget.guardianId}';
    var response = await http.get(url);
    setState(() {
      info = json.decode(response.body);
      if(info['patient'] == null){
        Navigator.push(context, new MaterialPageRoute(builder: (context){return new NoReservePage(patientId: widget.patientId,name: widget.name,gender: widget.gender,age: widget.age,tel: widget.tel,);}));
      }else{
        try {
          id = info['id'].toString();
        }on DioError catch(e){
        }
      }
      name = info['patient']['name'];
      gender = info['patient']['gender'];
      age = info['patient']['age'];
      appointmentTime = info['appointment_time'];
      phoneNumber = info['guardian']['phone_number'];


    });
    return response;
  }
  _getReserveCancel(String id) async{
    var url = 'http://172.20.10.4:8000/appointments/cancel_appoint/?id=$id';
    var response = await http.get(url);
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getReserveInfo();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientTabNavigator(index: 0,patientId: widget.patientId,name: widget.name,gender: widget.gender,age: widget.age,tel: widget.tel,);}));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title: Text('病人预约',style: TextStyle(fontSize: 18,color: Colors.black),),
      ),
      body: Column(
        children: <Widget>[
          DividerWithColor(text:'基本信息',color:Color(0xffB4D7D2)),
          OneLineInfo(
            name: '姓名',
            hintText: name,
            enable: false,
          ),
          OneLineInfo(
            name: '性别',
            hintText: gender,
            enable: false,
          ),
          OneLineInfo(
            name: '年龄',
            hintText: age,
            enable: false,
          ),
          DividerWithColor(text:'预约信息',color:Color(0xffB4D7D2)),
          OneLineInfo(
            name: '预约时间',
            hintText: appointmentTime,
            enable: false,
          ),
          DividerWithColor(text:'联系人信息',color:Color(0xffB4D7D2)),
          OneLineInfo(
            name: '电话',
            hintText: phoneNumber,
            enable: false,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 150),
            child: CupertinoButton(
                color: Colors.blueAccent,
                child: Text('取消预约',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  //send
                  _getReserveCancel(id);
                  Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientTabNavigator(index: 0,patientId: widget.patientId,);}));
                }
            ),
          )
        ],
      ),
    );
  }


}
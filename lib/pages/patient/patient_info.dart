import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PatientInfo extends StatefulWidget{
  PatientInfo({Key key,this.patientId}):super(key:key);
  final String patientId;
  @override
  _PatientInfo createState() {
    // TODO: implement createState
    return _PatientInfo();
  }

}

class _PatientInfo extends State<PatientInfo> {
  var name = '';
  var gender = '';
  var age = '';
  var tel = '';
  var mainIllness = '';
  var marriage = '';
  var occupation =  '';
  var nation = '';
  var province = '';
  var address = '';
  var patientId = '';
  var guardianId = '';

  var treatTime = '';
  var illnessNow = '';
  var illnessPast = '';
  var subVisitTime = '';
  var treatment = '';
  var  medicine = '';

  var info = [];
  _getPatientDrugInfo() async{
    var url = 'http://172.20.10.4:8000/treatships/guardian_get_treat_info/?patient_id=${widget.patientId}';
    var response = await http.get(url);

    setState(() {
      info = [];
      info = json.decode(response.body);
      name =  info[0]['patient']['name'];
      gender = info[0]['patient']['gender'];
      age = info[0]['patient']['age'];
      tel = info[0]['patient']['phone_number'];
      mainIllness = info[0]['patient']['main_illness'];
      marriage = info[0]['patient']['marriage'];
      occupation = info[0]['patient']['job'];
      nation = info[0]['patient']['nation'];
      province = info[0]['patient']['native_place'];
      address = info[0]['patient']['address'];
      patientId = info[0]['patient']['patient_id'];
      guardianId = info[0]['guardian']['guardian_id'];
      //      print(response.body);
    });
    return response;

  }
  @override
  void initState() {
    // TODO: implement initState
    _getPatientDrugInfo();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
            children: <Widget>[
              Container(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        '病人信息',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(text: '基本信息',),
              OneLineInfo(
                name: '姓名',
                enable: false,
                hintText: name,
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
              OneLineInfo(
                name: '手机号',
                hintText: tel,
                enable: false,
              ),
              OneLineInfo(
                name: '主要病情',
                hintText: mainIllness,
                enable: false,
              ),
              Divider(text: '其他信息',),
              OneLineInfo(
                name: '婚姻',
                hintText: marriage,
                enable: false,
              ),
              OneLineInfo(
                name: '职业',
                hintText: occupation,
                enable: false,
              ),
              OneLineInfo(
                name: '民族',
                hintText: nation,
                enable: false,
              ),
              OneLineInfo(
                name: '籍贯',
                hintText:province ,
                enable: false,
              ),
              OneLineInfo(
                name: '住址',
                hintText: address,
                enable: false,
              ),
              OneLineInfo(
                name: '身份证号',
                hintText: patientId ,
                enable: false,
              ),
              Divider(text: '联系人信息',),
              OneLineInfo(
                name: '身份证号',
                hintText: guardianId,
                enable: false,
              ),
              Divider(text: "病情信息",),
              Container(height: 530,
                child: ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {

                      if (info[index]['treat_time'] != null){
                        treatTime = info[index]['treat_time'];
                      }
                      if (info[index]['illness_now'] != null){
                        illnessNow = info[index]['illness_now'];
                      }
                      if (info[index]['illness_past'] != null){
                        illnessPast = info[index]['illness_past'];
                      }
                      if (info[index]['sub_visit_time'] != null ){
                        subVisitTime = info[index]['sub_visit_time'];
                      }
                      if (info[index]['treatment'] != null){
                        treatment = info[index]['treatment'];
                      }
                      if (info[index]['medicine'] != null){
                        medicine = info[index]['medicine'];
                      }
                    return IllList(
                      treatTime: info[index]['treat_time'],
                      illnessNow: info[index]['illness_now'],
                      illnessPast: info[index]['illness_past'],
                      subVisitTime: info[index]['sub_visit_time'],
                      treatment: info[index]['treatment'],
                      medicine: info[index]['medicine'],
                    );
                  },
                ),),
            ],
          )
      ),
    );

  }




}

class Divider extends StatelessWidget{
  Divider({Key key,this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 46,
      color: Color(0xffB4D7D2),
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xff659791),
            fontSize: 15
        ),
      ),
    );

  }

}
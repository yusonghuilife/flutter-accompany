import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:trip/pages/doctor/patient_basic_info.dart';
import 'package:trip/navigator/doctor_tab_navigator.dart';
import 'package:trip/pages/doctor/addNewIllInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PatientInfo extends StatefulWidget{
  PatientInfo({Key key,this.id,this.doctorId}):super(key:key);
  final String id;
  final String doctorId;
      @override
      _PatientInfo createState() {
        return _PatientInfo();
  }


}

class _PatientInfo extends State<PatientInfo> {
  var treatTime = '';
  var illnessNow = '';
  var illnessPast = '';
  var subVisitTime = '';
  var treatment = '';
  var  medicine = '';

  var info = [];
  _getPatientInfo() async{
    var url = 'http://172.20.10.4:8000/treatships/get_many_treatment_info/?patient_id=${widget.id}';
    var response = await http.get(url);

      setState(() {
//      info = [];
        info = json.decode(response.body);
//      print(response.body);
      });

    return response;

  }

  @override
  void initState() {
    super.initState();
    _getPatientInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 80,

            alignment: Alignment.center,
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                            return new DoctorTabNavigator(index: 0,tel: info[0]['doctor']['phone_number'],id: widget.doctorId,pass: info[0]['doctor']['password'],);
                          }
                        )
                      );
                    },
                    child: Text(
                      '返回',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.only(top: 100),
                child:DividerWithColor(
                  text: '病情信息',
                  color: Color(0xffB4D7D2),
                ),
              ),
          Container(height: 500,
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
                treatTime: treatTime,
                illnessNow: illnessNow,
                illnessPast: illnessPast,
                subVisitTime: subVisitTime,
                treatment: treatment,
                medicine: medicine,
              );
            },
          ),),

          Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 166,
                      height: 41,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0x11000000),width: 1),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientBasicInfo(id: widget.id,doctorId:widget.doctorId);}));
                        },
                        child: Text(
                          '病人基本情况',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            fontWeight: FontWeight.w300
                          ),

                        ),
                      )
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 166,
                      height: 41,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0x11000000),width: 1),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child:FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context){return new AddNewInfo(doctorId: widget.doctorId,patientId: widget.id,guardianId: info[0]['guardian'][''],);}));
                          },
                          child: Text(
                            '添加新的病情信息',
                              style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.blue,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                          )
                    )
                  ],
                ),
              ),

        ],
      )
     )
    );
  }

}

class DividerWithColor extends StatelessWidget{
  DividerWithColor({Key key,this.text,this.color}) : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 46,
      color: color,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFF659791),
            fontSize: 15
        ),
      ),
    );
  }
}

class YellowDivider extends StatelessWidget{
  YellowDivider({Key key,this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 46,
      color: Color(0xFFF9F0D5),
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFFEAB822),
            fontSize: 15
        ),
      ),
    );
  }
}

class IllList extends StatelessWidget{
  IllList({Key key,this.treatTime,this.illnessNow,this.illnessPast,this.subVisitTime,this.treatment,this.medicine}):super(key:key);
  final String treatTime;
  final String illnessNow;
  final String illnessPast;
  final String subVisitTime;
  final String treatment;
  final String medicine;
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(
          children: <Widget>[
            YellowDivider(text: treatTime),
            OneLineInfo(
              name: '现今病情',
              hintText: illnessNow,
              enable: false,
            ),
            MultiLineInfo(
              name: '以往病史',
              hintText: illnessPast,
              enable: false,
            ),
            OneLineInfo(
              name: '复诊时间',
              hintText: subVisitTime,
              enable: false,
            ),
            MultiLineInfo(
              name: '治疗方案',
              hintText: treatment,
              enable: false,
            ),
            MultiLineInfo(
              name: '开药及用法用量',
              hintText: medicine,
              enable: false,
            ),
          ],
        )

    );
  }

}
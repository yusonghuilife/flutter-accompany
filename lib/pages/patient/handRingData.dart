import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:trip/navigator/patient_tab_navigator.dart';
class HandRingData extends StatefulWidget{
  HandRingData({Key key,this.patientId,this.name,this.gender,this.age,this.tel}):super(key:key);
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _HandRingData createState() {
    // TODO: implement createState
    return _HandRingData();
  }

}

class _HandRingData extends State<HandRingData>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('病人手环数据',style: TextStyle(fontSize: 17,color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.blue,
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientTabNavigator(index : 0,patientId:widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel);}));
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          DividerWithColor(
            text: '当前健康指标',
            color: Color(0xffB4D7D2),
          ),
          OneLineInfo(
            name: '心率',
            hintText: '',
            enable: false,
          ),
          OneLineInfo(
            name: '步数',
            hintText: '',
            enable: false,
          ),
          OneLineInfo(
            name: '血压',
            hintText: '',
            enable: false,
          ),
          DividerWithColor(
            text: '近10分钟数据',
            color: Color(0xffB4D7D2),
          ),
        ],
      ),
    );
  }

}
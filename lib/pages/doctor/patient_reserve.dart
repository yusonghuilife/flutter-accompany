import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/navigator/doctor_tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';



class PatientReserve extends StatefulWidget{
  PatientReserve({Key key,this.id,this.doctorId,this.guardianId,this.dateTime}) : super(key: key);
  final String id;
  final String doctorId;
  final String guardianId;
  final String dateTime;

  @override
  _PatientReserveState createState() => _PatientReserveState();

}

class _PatientReserveState extends State<PatientReserve> {
  var info = {};
  var name = '';
  var gender = '';
  var age = '';
  var time = '';
  var tel = '';
  Color  handledBgColor = Colors.blue;
  Color  handledTextColor = Colors.white;
  _getReserveInfo() async{
    var url = 'http://172.20.10.4:8000/appointments/appointment_info_detail/?doctor_id=${widget.doctorId}&patient_id=${widget.id}&guardian_id=${widget.guardianId}&appointment_time=${widget.dateTime}';
    var response = await http.get(url);

    setState(() {
      info = json.decode(response.body);
      name = info['patient']['name'];
      gender = info['patient']['gender'];
      age = info['patient']['age'];
      time = info['appointment_time'];
      tel = info['guardian']['phone_number'];
      if(info['appointment_state'] == 'completed'){
        setState(() {
          handleText = '已处理';
          handledBgColor = Colors.white;
          handledTextColor = Color.fromARGB(100, 127, 127, 127);
        });
      }
    });
    return response;

  }

  _handleConfirmReserve(int id) async{
    FormData formData = new FormData.from({
      'id':id
    });
    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    var response = await dio.post('http://172.20.10.4:8000/appointments/change_appointment_state/', data: formData);
    if(response.statusCode == 200) {
     setState(() {
       handleText = '已处理';
       handledBgColor = Colors.white;
       handledTextColor = Color.fromARGB(100, 127, 127, 127);
     });
    }else{
      var dialog = CupertinoAlertDialog(
        content: Text(
          "处理失败",
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          CupertinoButton(
            child: Text("确定",
              style: TextStyle(
                  fontSize: 14
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
      showDialog(context: context, builder: (_) => dialog);
    }
  }
  String handleText = '完成预约';
  void initState() {
    super.initState();
      _getReserveInfo();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text('病人预约',style: TextStyle(fontSize: 20),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context){return new DoctorTabNavigator(index: 0,id: widget.doctorId,tel: info['doctor']['phone_number'],pass: info['doctor']['password'],);}));
                    },
                    child: Text('返回',style: TextStyle(fontSize: 16,color: Colors.blue),),),
                )
              ],
            ),
          ),
          DividerWithColor(
            text: '基本信息',
            color: Color(0xffB4D7D2),
          ),
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
          DividerWithColor(
            text: '预约时间',
            color: Color(0xffB4D7D2),
          ),
          OneLineInfo(
            name: '预约时间',
            hintText: time,
            enable: false,
          ),
          DividerWithColor(
            text: '联系人电话',
            color: Color(0xffB4D7D2),
          ),
          OneLineInfo(
            name: '电话',
            hintText: tel,
            enable: false,
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            height: 60,
            margin: EdgeInsets.fromLTRB(80,80,80,0),
//            padding: EdgeInsets.fromLTRB(65, 6, 65, 6),
            child: CupertinoButton(color: Colors.blue,child: Text('查看病情',style: TextStyle(color: Colors.white,fontSize: 17),), onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientInfo(id: widget.id,doctorId: widget.doctorId,);}));
            }),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            height: 60,
            margin: EdgeInsets.fromLTRB(80,20,80,0),
//            padding: EdgeInsets.fromLTRB(75, 6, 75, 6),
            child: CupertinoButton(color: handledBgColor,child: Text(handleText,style: TextStyle(color: handledTextColor,fontSize: 17),),
                onPressed: () async{
//                  if(info['appointment_state'] == 'appoint'){
//                    setState(() {
//                      handleText = '您已处理该预约';
//                      handledBgColor = Colors.white;
//                      handledTextColor = Color.fromARGB(100, 127, 127, 127);
//                    });
//                  }
              await _handleConfirmReserve(info['id']);
              if(info['appointment_state'] == 'appoint'){
                setState(() {
                  handleText = '已处理';
                  handledBgColor = Colors.white;
                  handledTextColor = Color.fromARGB(100, 127, 127, 127);
                });
              }
//              Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientInfo();}));
            }),
          )
        ],
      )
    );
  }

}
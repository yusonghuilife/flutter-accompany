import 'package:flutter/cupertino.dart';
import 'package:trip/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class PatientBasicInfo extends StatefulWidget{
  PatientBasicInfo({Key key,this.id,this.doctorId}):super(key:key);
  final String id;
  final String doctorId;
  @override
  _PatientBasicInfo createState() {
    return _PatientBasicInfo();
  }

}
class _PatientBasicInfo extends State<PatientBasicInfo> {
  var info = {};
  var name = '';
  var gender = '';
  var age = '';
  var marriage = '';
  var occupation = '';
  var nation = '';
  var province = '';
  var address = '';
  var id = '';
  var tel = '';
  var guardianId = '';
  var guardianTel = '';
  _getPatientBasicInfo() async{
    var url = 'http://172.20.10.4:8000/treatships/get_patient_basic_info/?patient_id=${widget.id}&doctor_id=${widget.doctorId}';
    var response = await http.get(url);

    setState(() {
      info = {};
      info = json.decode(response.body);
//      print(info);
      name = info['patient']['name'];
//      print(name);
      gender =  info['patient']['gender'];
      age = info['patient']['age'];
      marriage = info['patient']['marriage'];
      occupation = info['patient']['job'];
      nation = info['patient']['nation'];
      province = info['patient']['native_place'];
      address = info['patient']['address'];
      id = info['patient']['patient_id'];
      tel = info['patient']['phone_number'];
      guardianId = info['guardian']['guardian_id'];
      guardianTel = info['guardian']['phone_number'];
    });
    return response;

  }
 _changePatientInfo(String name,String phoneNum,String age) async{
   FormData formData = new FormData.from({
     'patient_id':widget.id,
     'name': name,
     'phone_number': phoneNum,
     'age':age
   });
   print("patient_id is "+ widget.id);
   print("name is "+ name);
   print("phone_number is "+ phoneNum);
   print("age is "+ age);



   var dio = new Dio();
   dio.options.responseType = ResponseType.PLAIN;
   var response = await dio.post('http://172.20.10.4:8000/patients/${widget.id}/change_patient/', data: formData);
   if(response.statusCode == 200) {
     setState(() {
       _getPatientBasicInfo();
     });
   }else{
     var dialog = CupertinoAlertDialog(
       content: Text(
         "修改失败",
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPatientBasicInfo();

  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model){
          return Scaffold(
            backgroundColor: Colors.white,
            body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child:DividerWithColor(
                          text: '基本信息',
                          color: Color(0xffB4D7D2),
                        ),
                      ),
                      OneLineInfo(
                        name: '姓名',
                        enable: true,
                        hintText: name,
                        func: 'addPatientName',
                        maxLength: 11,
                        textInputFormatter: WhitelistingTextInputFormatter(
                            RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
                      ),
                      OneLineInfo(
                        name: '性别',
                        enable: true,
                        hintText: gender,
                      ),
                      OneLineInfo(
                        name: '年龄',
                        enable: true,
                        hintText: age,
                        func: 'addPatientAge',
                        maxLength: 3,
                        textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,


                      ),
                      DividerWithColor(text: '其他信息', color: Color(0xffB4D7D2),),
                      OneLineInfo(
                        name: '婚姻',
                        enable: true,
                        hintText: marriage,
                      ),
                      OneLineInfo(
                        name: '职业',
                        enable: true,
                        hintText: occupation,
                      ),
                      OneLineInfo(
                        name: '民族',
                        enable: true,
                        hintText: nation,
                      ),
                      OneLineInfo(
                        name: '籍贯',
                        enable: true,
                        hintText: province,
                      ),
                      OneLineInfo(
                        name: '住址',
                        enable: true,
                        hintText: address,
                      ),
                      OneLineInfo(
                        name: '身份证号',
                        enable: false,
                        hintText: id,
                      ),
                      OneLineInfo(
                        name: '手机号',
                        enable: true,
                        hintText: tel,
                        textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                        type: TextInputType.text,
                        maxLength: 11,
                        func: 'addPatientMobile',
                      ),
                      DividerWithColor(text: '联系人信息', color: Color(0xffB4D7D2),),
                      OneLineInfo(
                        name: '身份证号',
                        enable: true,
                        hintText:  guardianId,
                        textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9X]")),
                        type: TextInputType.text,
                        maxLength: 18,
                      ),
                      OneLineInfo(
                        name: '手机号',
                        enable: true,
                        hintText: guardianTel,
                        textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                        type: TextInputType.text,
                        maxLength: 11,
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    height: 80,
//                    padding: EdgeInsets.only(top: 10),
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
                                    return new PatientInfo(id: widget.id,doctorId: widget.doctorId,);
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
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              //send msg
                              setState(() {
                                if(model.addPatientName == '') {
                                  model.addPatientName = info['patient']['name'];
                                }
                                if(model.addPatientMobile == ''){
                                  model.addPatientMobile =info['patient']['phone_number'];
                                }
                                if(model.addPatientAge == ''){
                                  model.addPatientAge = info['patient']['age'];
                                }

                              });
                              _changePatientInfo(model.addPatientName, model.addPatientMobile, model.addPatientAge);
                            },
                            child: Text(
                              '修改',
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
                ],
              ),
            )
          );
        }
      );
    }
  }


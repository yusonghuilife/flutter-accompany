import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/scoped_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:trip/pages/doctor/patient_info.dart';
class AddNewInfo extends StatefulWidget{
  AddNewInfo({Key key,this.doctorId,this.patientId,this.guardianId}):super(key:key);
  final String doctorId;
  final String patientId;
  final String guardianId;
  @override
  _AddNewInfo createState() {
    // TODO: implement createState
    return _AddNewInfo();
  }

}

class _AddNewInfo extends State<AddNewInfo>{
  _addNewIllInfo(
      String addPatientIllness,
      String addPatientPassIllness,
      String addPatientReTreatmentTime,
      String addPatientTreatmentMethod,
      String addPatientProcedure
      )async{
    String month;
    String day;

    if(new DateTime.now().month.toString().length != 2){
      month = '0'+ new DateTime.now().month.toString();
    }else{
      month = new DateTime.now().month.toString();
    }

    if(new DateTime.now().day.toString().length != 2){
      day = '0'+ new DateTime.now().day.toString();
    }else{
      day = new DateTime.now().day.toString();
    }

    FormData formData = new FormData.from({
      'doctor_id':widget.doctorId,
      'patient_id':widget.patientId,
      'guardian_id':widget.guardianId,
      'illness_now':addPatientIllness,
      'illness_past':addPatientPassIllness,
      'sub_visit_time':addPatientReTreatmentTime,
      'treat_time':'${new DateTime.now().year}-$month-$day',
      'medicine':addPatientProcedure,
      'treatment':addPatientTreatmentMethod
    });
    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    var response = await dio.post('http://172.20.10.4:8000/treatships/add_treat_info/', data: formData);
    var jsonStr = json.decode(response.toString());
    if(jsonStr['status'] == '添加病情信息成功'){
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) {
              return  PatientInfo(id: widget.patientId,doctorId: widget.doctorId);
            }
          )
      );
      }else{
      var dialog = CupertinoAlertDialog(
        content: Text(
          "添加失败，请重新添加",
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
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.blue,
            onPressed: (){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) {
                    return  PatientInfo(id: widget.patientId,doctorId: widget.doctorId);
                  }
                  )
              );
            },

          ),
          title: Text(
            '添加病人', style: TextStyle(fontSize: 18, color: Colors.black),),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Divider(text: "病情信息",),
            OneLineInfo(
              name: '现今病情',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
              type: TextInputType.text,
              maxLength: 16,
              func: 'addPatientIllness',
              enable: true,
            ),
            MultiLineInfo(
              name: '以往病史',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
              type: TextInputType.text,
              maxLength: 100,
              func: 'addPatientPassIllness',
              enable: true,
            ),
            OneLineInfo(
              name: '复诊时间',
              hintText: 'YYYY-MM-DD',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9a-zA-Z\u4e00-\u9fa5-]")),
              type: TextInputType.text,
              maxLength: 10,
              func: 'addPatientReTreatmentTime',
              enable: true,
            ),
            MultiLineInfo(
              name: '治疗方案',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
              type: TextInputType.text,
              maxLength: 100,
              func: 'addPatientTreatmentMethod',
              enable: true,
            ),
            MultiLineInfo(
              name: '开药及用法用量',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
              type: TextInputType.text,
              maxLength: 100,
              func: 'addPatientProcedure',
              enable: true,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: CupertinoButton(
                color: Colors.blue,
                child: Text('保存病人病情信息',
                  style: TextStyle(color: Colors.white, fontSize: 15),),
                onPressed: () {
                  _addNewIllInfo(
                    model.addPatientIllness,
                    model.addPatientPassIllness,
                    model.addPatientReTreatmentTime,
                    model.addPatientTreatmentMethod,
                    model.addPatientProcedure
                  );
                },
              ),
            )
          ],
        ),
      );
    });
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
      color: Color(0x3a979797),
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFF9E9D9D),
            fontSize: 15
        ),
      ),
    );

  }

}
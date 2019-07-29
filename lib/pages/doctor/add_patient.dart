import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/navigator/doctor_tab_navigator.dart';

import 'package:dio/dio.dart';
class AddPatient extends StatefulWidget{
  AddPatient({Key key,this.id,this.pass,this.tel}) : super(key :key);
  final String id;
  final String pass;
  final String tel;
  @override
  _AddPatientState createState() => _AddPatientState();

}

class _AddPatientState extends State<AddPatient> {

  _addPatient(
      String patientId,
      String guardianId,
      String name,
      String phoneNumber,
      String gender,
      String marriage,
      String age,
      String job,
      String nation,
      String nativePlace,
      String address,
      String mainIllness,
      String illnessNow,
      String illnessPast,
      String subVisitTime,
      String medicine,
      String treatment,
      ) async{
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
      'doctor_id': widget.id,
      'patient_id': patientId,
      'guardian_id': guardianId,
      'name': name,
      'password': widget.pass,
      "phone_number": phoneNumber,
      "gender": gender,
      "marriage": marriage,
      "age": age,
      "job": job,
      "nation": nation,
      "native_place": nativePlace,
      "address": address,
      "main_illness": mainIllness,
      "illness_now": illnessNow,
      "illness_past": illnessPast,
      "sub_visit_time": subVisitTime,
      "treat_time": '${new DateTime.now().year}-$month-$day',
      "medicine": medicine,
      "treatment": treatment,

    });



    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    var response = await dio.post('http://172.20.10.4:8000/treatships/add_treatship/', data: formData);
    if(response.statusCode == 200){
      Navigator.push(context,
          new MaterialPageRoute(builder: (context){
            return new DoctorTabNavigator(index: 0,);
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
      return new Scaffold(
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
                        '添加病人',
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
                                return new DoctorTabNavigator(index: 0,tel: widget.tel,id: widget.id,pass: widget.pass,);
                              }
                            )
                          );
                        },
                        child: Text(
                          '取消',
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
              Divider(text: '基本信息',),
              OneLineInfo(
                name: '姓名',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 15,
                func: 'addPatientName',
                enable: true,
              ),
              OneLineInfo(
                name: '性别',
                hintText: '男/女',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 6,
                func: 'addPatientGender',
                enable: true,
              ),
              OneLineInfo(
                name: '年龄',
                textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                type: TextInputType.text,
                maxLength: 3,
                func: 'addPatientAge',
                enable: true,
              ),
              OneLineInfo(
                name: '手机号',
                textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                type: TextInputType.text,
                maxLength: 11,
                func: 'addPatientMobile',
                enable: true,
              ),
              OneLineInfo(
                name: '主要病情',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 11,
                func: 'addPatientNowIll',
                enable: true,
              ),
              Divider(text: '其他信息',),
              OneLineInfo(
                name: '婚姻',
                hintText: '已婚/未婚',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 6,
                func: 'addPatientMarried',
                enable: true,
              ),
              OneLineInfo(
                name: '职业',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 16,
                func: 'addPatientOccupation',
                enable: true,
              ),
              OneLineInfo(
                name: '民族',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 16,
                func: 'addPatientNation',
                enable: true,
              ),
              OneLineInfo(
                name: '籍贯',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 16,
                func: 'addPatientProvince',
                enable: true,
              ),
              OneLineInfo(
                name: '住址',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
                type: TextInputType.text,
                maxLength: 20,
                func: 'addPatientAddress',
                enable: true,
              ),
              OneLineInfo(
                name: '身份证号',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[0-9X]")),
                type: TextInputType.text,
                maxLength: 18,
                func: 'addPatientId',
                enable: true,
              ),
              Divider(text: '联系人信息',),
              OneLineInfo(
                name: '身份证号',
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[0-9X]")),
                type: TextInputType.text,
                maxLength: 18,
                func: 'addPatientContactId',
                enable: true,
              ),
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
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: new CupertinoButton(
                  onPressed: (){
//                    print(model.addPatientId);
                RegExp idCode = new RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
                if(idCode.hasMatch(model.addPatientId) && idCode.hasMatch(model.addPatientContactId)){
                // sendData()
                  _addPatient(
                      model.addPatientId,
                      model.addPatientContactId,
                      model.addPatientName,
                      model.addPatientMobile,
                      model.addPatientGender,
                      model.addPatientMarried,
                      model.addPatientAge,
                      model.addPatientOccupation,
                      model.addPatientNation,
                      model.addPatientProvince,
                      model.addPatientAddress,
                      model.addPatientIllness,
                      model.addPatientNowIll,
                      model.addPatientPassIllness,
                      model.addPatientReTreatmentTime,
                      model.addPatientTreatmentMethod,
                      model.addPatientProcedure
                  );
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                        return new DoctorTabNavigator(index: 0,tel: widget.tel,id: widget.id,pass: widget.pass,);
                      }
                    )
                  );
                }else{
                var dialog = CupertinoAlertDialog(
                content: Text(
                "您输入的身份证不符合格式要求，请重新输入",
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
                },
                  pressedOpacity: 0.9,
                  color: Colors.blue,
                  child: Text(
                    '保存病人信息',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          )
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

class OneLineInfo extends StatefulWidget{
  OneLineInfo({Key key,this.hintText,this.name,this.textInputFormatter,this.maxLength,this.type,this.func,this.enable,this.defaultText}):super(key : key);

  final String hintText;
  final String name;
  final TextInputFormatter textInputFormatter;
  final TextInputType type;
  final int maxLength;
  final String func;
  final bool enable;
  final String defaultText;
  @override
  _OneLineInfo createState() {
    // TODO: implement createState
    return new _OneLineInfo();
  }

}

class _OneLineInfo extends State<OneLineInfo>{
  void initState(){
    controller.text = widget.defaultText;
  }

  double cursorSize = 1;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model) {
    return Container(
      height: 46,
      decoration: new BoxDecoration(
          border: new Border(top: BorderSide(
              width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),
            bottom: BorderSide(
                width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: Text(widget.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF659791),
                ),
                decoration: new InputDecoration.collapsed(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(100, 150, 150, 150),
                  )
                ),
                maxLines: 1,
                enabled: widget.enable,
                cursorWidth: cursorSize,
                cursorColor: Color.fromARGB(90, 207, 207, 207),
                controller: controller,
                keyboardType: widget.type,
                inputFormatters: [widget.textInputFormatter],
                onChanged: (str) {
                  if (str.length > widget.maxLength) {
                    controller.text = str.substring(0, widget.maxLength);
                    setState(() {
                      cursorSize = 0;
                    });
                  }else{
                    setState(() {
                      cursorSize = 1;
                    });
                  }
                  switch (widget.func) {
                    case 'addPatientName':
                      model.addPatientName = controller.text;
                      break;
                    case 'addPatientGender':
                      model.addPatientGender = controller.text;
                      break;
                    case 'addPatientAge':
                      model.addPatientAge = controller.text;
                      break;
                    case 'addPatientMobile':
                      model.addPatientMobile = controller.text;
                      break;
                    case 'addPatientMarried':
                      model.addPatientMarried = controller.text;
                      break;
                    case 'addPatientOccupation':
                      model.addPatientOccupation = controller.text;
                      break;
                    case 'addPatientNation':
                      model.addPatientNation = controller.text;
                      break;
                    case 'addPatientProvince':
                      model.addPatientProvince = controller.text;
                      break;
                    case 'addPatientAddress':
                      model.addPatientAddress = controller.text;
                      break;
                    case 'addPatientId':
                      model.addPatientId = controller.text;
                      break;
                    case 'addPatientIllness':
                      model.addPatientIllness = controller.text;
                      break;
                    case 'addPatientReTreatmentTime':
                      model.addPatientReTreatmentTime = controller.text;
                      break;
                    case 'addPatientContactId':
                      model.addPatientContactId = controller.text;
                      break;
                    case 'addPatientNowIll':
                      model.addPatientNowIll = controller.text;
                      break;
                    case 'addPatientProcedure':
                      model.addPatientProcedure = controller.text;
                      break;
                    case 'patientAppName':
                      model.patientAppName = controller.text;
                      break;
                    case 'patientAppGender':
                      model.patientAppGender = controller.text;
                      break;
                    case 'patientAppAge':
                      model.patientAppAge = controller.text;
                      break;
                    case 'patientAppReserveTime':
                      model.patientAppReserveTime = controller.text;
                      break;
                    case 'patientAppTel':
                      model.patientAppTel = controller.text;
                      break;
                  }
                },

              ),
            ),
          )
        ],
      ),
    );
  });
  }

}

class MultiLineInfo extends StatefulWidget{
  MultiLineInfo({Key key,this.hintText,this.name,this.textInputFormatter,this.maxLength,this.type,this.func,this.enable}):super(key : key);
  final String hintText;
  final String name;
  final TextInputFormatter textInputFormatter;
  final TextInputType type;
  final int maxLength;
  final String func;
  final bool enable;

  @override
  _MultiLineInfo createState() {
    return _MultiLineInfo();
  }

}
class _MultiLineInfo extends State<MultiLineInfo> {
  double cursorSize = 1;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model) {
      return Container(
        decoration: new BoxDecoration(
            border: new Border(top: BorderSide(
                width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),
              bottom: BorderSide(
                  width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),)
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
              alignment: Alignment.centerLeft,
              child: Text(widget.name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
              alignment: Alignment.center,
              child: TextField(
//                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF659791),
                ),
                decoration: new InputDecoration.collapsed(
                  hintText: widget.hintText,
                ),
                maxLines: 3,
                enabled: widget.enable,
                cursorWidth: cursorSize,
                cursorColor: Color.fromARGB(90, 207, 207, 207),
                controller: controller,
                keyboardType: widget.type,
                inputFormatters: [widget.textInputFormatter],
                onChanged: (str) {
                  switch (widget.func) {
                    case 'addPatientPassIllness':
                      model.addPatientPassIllness = controller.text;
                      break;
                    case 'addPatientTreatmentMethod':
                      model.addPatientTreatmentMethod = controller.text;
                      break;
                    case 'addPatientProcedure':
                      model.addPatientProcedure = controller.text;
                      break;
                  }
                },

              ),
            )
          ],
        ),
      );
    });
  }

}
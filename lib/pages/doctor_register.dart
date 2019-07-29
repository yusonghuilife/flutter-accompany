import 'package:flutter/material.dart';
import 'package:trip/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/main.dart';
import 'package:flutter/services.dart';
import 'package:trip/pages/patient_register.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class DoctorRegister extends StatefulWidget{
  @override
  _DoctorRegister createState() {
    return new _DoctorRegister();
  }

}

class _DoctorRegister extends State<DoctorRegister> {
  TextEditingController controller = TextEditingController();
  _onCheckInput(String id, String pass, String rePass,String name,String tel,String unit,String num,String title,String intro) async{
    RegExp idCode = new RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
    if (!idCode.hasMatch(id)) {
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
    }else if(pass != rePass){
      var dialog = CupertinoAlertDialog(
        content: Text(
          "您两次输入的密码不一致，请重新输入",
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
    }else{
      //发送数据到后台
      FormData formData = new FormData.from({
        'name':name,
        'password':pass,
        'doctor_id':id,
        'phone_number':tel,
        'working_unit':unit,
        'working_num':num,
        'working_title':title,
        'resume':intro
      });
      var dio = new Dio();
      dio.options.responseType = ResponseType.PLAIN;
      var response = await dio.post('http://172.20.10.4:8000/doctors/doctor_register/', data: formData);
      Navigator.push(context,
          new MaterialPageRoute(builder: (context){
            return new LoginMain();
          }
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    InputContainer name = new InputContainer(

        hintText: '姓名',
        marginTop: 50,
        textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
        isHide: false,
        maxLength: 15,
        type: TextInputType.text,
        func: 'setDoctorRegisterName'
    );
    InputContainer ID = new InputContainer(
        hintText: '身份证号',
        marginTop: 0,
        textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9X]")),
        isHide: false,
        maxLength: 18,
        type: TextInputType.text,
        func: 'setDoctorRegisterId'
    );
    InputContainer mobileNum = new InputContainer(
        hintText: '手机号',
        marginTop: 0,
        textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
        isHide: false,
        maxLength: 11,
        type: TextInputType.number,
        func: 'setDoctorRegisterMobile'
    );
    InputContainer company = new InputContainer(
      hintText: '从业单位',
      marginTop: 20,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
      isHide: false,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setDoctorRegisterCompany',
    );
    InputContainer companyId = new InputContainer(
      hintText: '工号',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]")),
      isHide: false,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setDoctorRegisterCompanyId',
    );
    InputContainer companyLevel = new InputContainer(
      hintText: '职称',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
      isHide: false,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setDoctorRegisterCompanyLevel',
    );
    InputContainer pass = new InputContainer(
      hintText: '密码',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
      isHide: true,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setDoctorRegisterPass',
    );
    InputContainer rePass = new InputContainer(
      hintText: '确认密码',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]")),
      isHide: true,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setDoctorRegisterRePass',
    );
    return new ScopedModelDescendant<ProjectModel>(
      builder: (context,child,model) {
        return Scaffold (
          backgroundColor: Color(0xFFF9F0D5),
          body: new ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: new Text('Accompany',
                  style: TextStyle(
                      color: Color(0xFF556D8A),
                      fontFamily: "PingFang",
                      fontSize: 55
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                alignment: Alignment.center,
                child: new Text('医者，仁心',
                  style: TextStyle(
                      color: Color(0xFF556D8A),
                      fontFamily: 'PingFang',
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              name,
              ID,
              mobileNum,
              new ConfirmCode(
                func: 'setDoctorRegisterConfirmCode',
              ),
              company,
              companyId,
              companyLevel,
              Container(
                width: 300,
                height: 134,
                margin: EdgeInsets.fromLTRB(28, 10, 30, 20),
                padding: EdgeInsets.fromLTRB(20, 0, 5, 0),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(
                  color: Color.fromARGB(90, 207, 207, 207), width: 1),
                  borderRadius: new BorderRadius.circular(6.0)
                ),
                child: new TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  decoration: new InputDecoration.collapsed(
                    hintText: '请输入简介',
                    hintStyle: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  maxLines: 4,
                  cursorWidth: 1,
                  cursorColor: Color.fromARGB(90, 207, 207, 207),
                  keyboardType: TextInputType.text,
                  inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z\u4e00-\u9fa5]"))],
                  onChanged: (str) {
                    setState(() {
                      model.setDoctorRegisterIntro(controller.text);
                    });
                  },
                ),
              ),
              pass,
              rePass,
              Container(
                margin: EdgeInsets.fromLTRB(110, 10, 110, 0),
                alignment: Alignment.center,
                width: 100,
                height: 50,
                decoration: new BoxDecoration(
                    color: Colors.white,
//              border: new Border.all(color: Colors.redAccent),
                    border: new Border.all(color: Color(0x1a979797)),
                    borderRadius: new BorderRadius.circular(6.0)
                ),
                child: MaterialButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onPressed: () {
                    _onCheckInput(
                        model.doctorRegisterId,
                        model.doctorRegisterPass,
                        model.doctorRegisterRePass,
                        model.doctorRegisterName,
                        model.doctorRegisterMobile,
                        model.doctorRegisterCompany,
                        model.doctorRegisterCompanyId,
                        model.doctorRegisterCompanyLevel,
                        model.doctorRegisterIntro
                    );
                  },
                  textColor: Color(0xFF4A90E2),
                  child: Text('注册',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'PingFang',
                        fontSize: 14
                    ),
                  ),
                ),
              ),
              new FlatButton(
                  onPressed: (){
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context){
                          return new LoginMain();
                        }
                        )
                    );
                  },
                  child: Text('已有账号？登陆',
                    style: TextStyle(
                        fontFamily: 'PingFang',
                        fontSize: 13,
                        color: Colors.orangeAccent
                    ),
                  )
              ),
            ],
          ),
        );
      }
    );
  }

}
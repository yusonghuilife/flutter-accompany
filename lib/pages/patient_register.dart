import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip/main.dart';
import 'package:trip/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class PatientRegister extends StatefulWidget{
  @override
  _PatientRegister createState() {
    return new _PatientRegister();
  }

}

class _PatientRegister extends State<PatientRegister> {
  String hint = '确认密码';
  final GlobalKey<InputContainerInner> _myKeyName = new GlobalKey();
  final GlobalKey<InputContainerInner> _myKeyID = new GlobalKey();
  final GlobalKey<InputContainerInner> _myKeyMobileNumber = new GlobalKey();
  final GlobalKey<InputContainerInner> _myKeyPassWord = new GlobalKey();
  final GlobalKey<InputContainerInner> _myKeyConfirmPassWord = new GlobalKey();

  _onCheckInput(String id,String pass, String rePass,String name,String mobile) async{
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
      FormData formData = new FormData.from({
        'name':name,
        'password':pass,
        'phone_number':mobile,
        'guardian_id':id
      });
      var dio = new Dio();
      dio.options.responseType = ResponseType.PLAIN;
      var response = await dio.post('http://172.20.10.4:8000/guardians/guardian_register/', data: formData);
      //发送数据到后台

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
      key: _myKeyName,
      hintText: '姓名',
      marginTop: 80,
      textInputFormatter: BlacklistingTextInputFormatter(RegExp("[0-9]")),
      isHide: false,
      maxLength: 15,
      type: TextInputType.text,
      func: 'setPatientRegisterName'
    );
    InputContainer ID = new InputContainer(
      key: _myKeyID,
      hintText: '身份证号',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9X]")),
      isHide: false,
      maxLength: 18,
      type: TextInputType.text,
      func: 'setPatientRegisterId'
    );
    InputContainer mobileNum = new InputContainer(
      key: _myKeyMobileNumber,
      hintText: '请输入手机号',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
      isHide: false,
      maxLength: 11,
      type: TextInputType.number,
      func: 'setPatientRegisterMobile'
    );
    InputContainer passWord = new InputContainer(
      key: _myKeyPassWord,
      hintText:  '密码',
      marginTop: 20,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]")),
      isHide: true,
      maxLength: 20,
      type: TextInputType.text,
      func: 'setPatientRegisterPass'
    );
    InputContainer passConfirm = new InputContainer(
      key: _myKeyConfirmPassWord,
      hintText:  '$hint',
      marginTop: 0,
      textInputFormatter: WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]")),
      isHide: true,
      maxLength: 20,
      type: TextInputType.text,
      func: 'setPatientRegisterRePass',
    );
    return ScopedModelDescendant<ProjectModel>(
        builder: (context,child,model) {
          return Scaffold(

            backgroundColor: Color(0xFFF9F0D5),
            body:
             new ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 90),
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
              child: new Text('病人需要的不仅仅是医治，还有「陪伴」',
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
//                new ConfirmCode(
//                  func: 'setPatientRegisterConfirmCode',
//                ),
                passWord,
                passConfirm,
                new Container(
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
                  _onCheckInput(model.patientRegisterId,model.patientRegisterPass,model.patientRegisterRePass,model.patientRegisterName,model.patientRegisterMobile);
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
      },
    );
  }


}

class ConfirmCode extends StatefulWidget{
  ConfirmCode({Key key,this.func}) :super(key : key);
  final String func;
  @override
  _ConfirmCode createState() {
    return new _ConfirmCode();
  }

}

class _ConfirmCode extends State<ConfirmCode>{
  TextEditingController controller = TextEditingController();
  double cursorSize = 1;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(
      builder: (context,child,model) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
              width: 123,
              height: 40,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(
                      color: Color.fromARGB(100, 255, 255, 255)),
                  borderRadius: new BorderRadius.circular(6.0)
              ),
              child: new FlatButton(
                onPressed: () {

                },
                textColor: Color(0xFFC39999),
                color: Color.fromARGB(100, 255, 255, 255),
                child: Text('发送验证码',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'PingFang',
                  ),
                ),
              )
          ),
          Container(
            width: 160,
            height: 40,
            margin: EdgeInsets.only(right: 40),
            padding: EdgeInsets.only(left: 50),
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
                  hintText: '验证码',
                  hintStyle: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                maxLines: 1,
                cursorWidth: cursorSize,
                cursorColor: Color.fromARGB(90, 207, 207, 207),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                onChanged: (str) {
                  if (str.length > 6) {
                    controller.text = str.substring(0, 6);
                    setState(() {
                      this.cursorSize = 0;
                    });
                  } else {
                    setState(() {
                      this.cursorSize = 1;
                      switch (widget.func) {
                        case 'setDoctorRegisterConfirmCode':
                          model.setDoctorRegisterConfirmCode(controller.text);
                          break;
                        case 'setPatientRegisterConfirmCode':
                          model.setPatientRegisterConfirmCode(controller.text);
                          break;
                      }

                    });
                  } //end if
                }
            ),
          )
        ],
      );
     }
    );
  }


}


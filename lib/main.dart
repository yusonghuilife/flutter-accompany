import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trip/pages/patient_register.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/scoped_model.dart';
import 'package:trip/navigator/doctor_tab_navigator.dart';
import 'package:trip/navigator/patient_tab_navigator.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
//import 'package:flutter_amap/flutter_amap.dart';
void main(){
//  FlutterAmap.setApiKey("947aeb4acf9c9d5fdd0176a516e80a7e	");
  runApp(new Login());
}

class Login extends StatelessWidget {
  ProjectModel passWordModel = new ProjectModel();
  @override
  Widget build(BuildContext context) {
  return ScopedModel<ProjectModel>(
    model: passWordModel,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginMain(),
      )
    );
  }

  }

class LoginMain extends StatefulWidget{


  @override
  _LoginMain createState() => new _LoginMain();

}

class _LoginMain extends State<LoginMain> {
  var info = {};
  _handleDoctorLogin(String tel,String pass) async{
    FormData formData = new FormData.from({
      'phone_number': tel,
      'password': pass,
    });
    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    var response = await dio.post('http://172.20.10.4:8000/doctors/doctor_login/', data: formData);

    setState(() {
      info = json.decode(response.data);
    });
    Navigator.push(context,
        new MaterialPageRoute(builder: (context){

          return new DoctorTabNavigator(index: 0,tel: info['phone_number'],id:info['doctor_id'],pass: pass);
        }
      )
    );
//    Navigator.push(context,
//        new MaterialPageRoute(builder: (context){
//
//          return new DoctorTabNavigator(index: 0,tel: info['phone_number'],id:info['doctor_id'],pass: pass);
//        }
//        )
//    );
    return response;


  }
  _handlePatientLogin(String tel,String pass) async{
    FormData formData = new FormData.from({
      'phone_number': tel,
      'password': pass,
    });
    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    var response = await dio.post('http://172.20.10.4:8000/guardians/guardian_login/', data: formData);

    setState(() {
      info = json.decode(response.data);
    });

    Navigator.push(context,
        new MaterialPageRoute(builder: (context){
          return new PatientTabNavigator(index: 0,patientId: info['patient']['patient_id'],name:info['patient']['name'],gender:info['patient']['gender'],age:info['patient']['age'],tel:info['guardian']['phone_number'],);
        }
      )
    );

//    Navigator.push(context,
//        new MaterialPageRoute(builder: (context){
//          return new PatientTabNavigator(index: 0,);
//        }
//        )
//    );
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model) {
      return Scaffold(
        backgroundColor: Color(0xFFF9F0D5),
        body: new SingleChildScrollView(
          child: new Column(
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
                margin: EdgeInsets.fromLTRB(0, 10, 30, 0),
                alignment: Alignment.centerRight,
                child: new Text('陪伴。',
                  style: TextStyle(
                      color: Color(0xFF556D8A),
                      fontFamily: 'PingFang',
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              new InputContainer(
                hintText: '请输入手机号',
                marginTop: 100,
                textInputFormatter: WhitelistingTextInputFormatter.digitsOnly,
                isHide: false,
                maxLength: 11,
                type: TextInputType.number,
                func: 'setLoginMobile',
              ),
              new InputContainer(
                hintText: '请输入密码',
                marginTop: 15,
                textInputFormatter: WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z0-9]")),
                isHide: true,
                maxLength: 20,
                type: TextInputType.text,
                func: 'setLoginPass',
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: new RaisedButton(
//              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  splashColor: Colors.white,
                  onPressed: (){_handleDoctorLogin(model.loginMobile,model.loginPass);},
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text('医生登陆',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontFamily: 'PingFang'
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 7, 40, 20),
                child: new RaisedButton(
                  splashColor: Colors.white,
//              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  onPressed: (){_handlePatientLogin(model.loginMobile,model.loginPass);},
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(35, 9, 35, 9),
                    child: Text('监护人登陆',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontFamily: 'PingFang'
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 60, 10, 10),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Container(
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) {
                                      return new PatientRegister();
                                    }
                                  )
                                );
                              },
                              child: Text('医生注册',
                                style: TextStyle(
                                    fontFamily: 'PingFang',
                                    fontSize: 13,
                                    color: Colors.orangeAccent
                                ),
                              )
                          ),
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                        ),
                      ),
                      new Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 40,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (context) {
                                              return new PatientRegister();
                                            }
                                        )
                                    );
                                  },
                                  child: Text('监护人注册',
                                    style: TextStyle(
                                        fontFamily: 'PingFang',
                                        fontSize: 13,
                                        color: Colors.orangeAccent
                                    ),
                                  )
                              )
                          )
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  });
  }

}


class InputContainer extends StatefulWidget{
  InputContainer({Key key,this.hintText,this.marginTop,this.textInputFormatter,this.isHide,this.maxLength,this.type,this.func}) : super(key : key);
  final String hintText ;
  final double marginTop;
  final TextInputFormatter textInputFormatter;
  final bool isHide;
  final int maxLength;
  final TextInputType type;
  final InputContainerInner input = new InputContainerInner();
  final String func;

  @override
  State<StatefulWidget> createState() {
    return input;
  }


}

class InputContainerInner extends State<InputContainer>{
//  final GlobalKey<InputContainerInner> containerKey = new GlobalKey();
  TextEditingController controller = TextEditingController();
  String num = '';
  double cursorSize = 1;
  Color hintColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(
      builder: (context,child,model) {
        return Container(
          margin: EdgeInsets.fromLTRB(30, widget.marginTop, 30, 20),
          padding: EdgeInsets.only(left: 40),
          alignment: Alignment.center,
          width: 300,
          height: 39,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(
                  color: Color.fromARGB(90, 207, 207, 207), width: 2),
              borderRadius: new BorderRadius.circular(6.0)
          ),
          child: TextField(
            style: TextStyle(fontSize: 15, color: Colors.grey),
            obscureText: widget.isHide,
            decoration: new InputDecoration.collapsed(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w300, color: hintColor),
            ),
            maxLines: 1,
            cursorWidth: cursorSize,
            cursorColor: Color.fromARGB(90, 207, 207, 207),
            controller: controller,
            keyboardType: widget.type,
            inputFormatters: [widget.textInputFormatter],
            onChanged: (str) {
              if (str.length > widget.maxLength) {
                controller.text = str.substring(0, widget.maxLength);
                setState(() {
                  this.cursorSize = 0;
                });
              } else {
                setState(() {
                  this.cursorSize = 1;
                  switch(widget.func) {
                    case 'setLoginMobile':
                      model.setLoginMobile(controller.text);
                      break;
                    case 'setLoginPass':
                      model.setLoginPass(controller.text);
                      break;
                    case 'setDoctorRegisterName':
                      model.setDoctorRegisterName(controller.text);
                      break;
                    case 'setDoctorRegisterId':
                      model.setDoctorRegisterId(controller.text);
                      break;
                    case 'setDoctorRegisterMobile':
                      model.setDoctorRegisterMobile(controller.text);
                      break;
                    case 'setDoctorRegisterPass':
                      model.setDoctorRegisterPass(controller.text);
                      break;
                    case 'setDoctorRegisterRePass':
                      model.setDoctorRegisterRePass(controller.text);
                      break;
                    case 'setDoctorRegisterCompany':
                      model.setDoctorRegisterCompany(controller.text);
                      break;
                    case 'setDoctorRegisterCompanyLevel':
                      model.setDoctorRegisterCompanyLevel(controller.text);
                      break;
                    case 'setDoctorRegisterCompanyId':
                      model.setDoctorRegisterCompanyId(controller.text);
                      break;
                    case 'setDoctorRegisterIntro':
                      model.setDoctorRegisterIntro(controller.text);
                      break;
                    case 'setPatientRegisterName':
                      model.setPatientRegisterName(controller.text);
                      break;
                    case 'setPatientRegisterId':
                      model.setPatientRegisterId(controller.text);
                      break;
                    case 'setPatientRegisterMobile':
                      model.setPatientRegisterMobile(controller.text);
                      break;
                    case 'setPatientRegisterPass':
                      model.setPatientRegisterPass(controller.text);
                      break;
                    case 'setPatientRegisterRePass':
                      model.setPatientRegisterRePass(controller.text);
                      break;
                  }
                });
              }
            }, //onchange
          ),
        );
      },
    );

  }

}
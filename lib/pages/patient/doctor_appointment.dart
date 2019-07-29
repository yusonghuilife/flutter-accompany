import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/scoped_model.dart';
import 'package:trip/navigator/patient_tab_navigator.dart';
import 'package:dio/dio.dart';
class DoctorAppointment extends StatefulWidget{
  DoctorAppointment({Key key,this.doctorId,this.patientId,this.guardianId,this.name,this.gender,this.age,this.tel}):super(key:key);
  final String doctorId;
  final String patientId;
  final String guardianId;
  final String name;
  final String gender;
  final String age;
  final String tel;

  @override
  _DoctorAppointment createState() {
    // TODO: implement createState
    return _DoctorAppointment();
  }

}

class _DoctorAppointment extends State<DoctorAppointment> {
  _handleAppointment(String time) async{
    String state = "appoint";
    FormData formData = new FormData.from({
      'appointment_time': time,
      'appointment_state': state,
      'doctor_id':widget.doctorId,
      'patient_id':widget.patientId,
      'guardian_id':widget.guardianId
    });
//    print(time);
//    print(time);
//    print(widget.doctorId);
//    print(widget.patientId);
//    print(widget.guardianId);
    var dio = new Dio();
    dio.options.responseType = ResponseType.PLAIN;
    try {
      var response = await dio.post(
          'http://172.20.10.4:8000/appointments/guardian_appoint/',
          data: formData);
    }on DioError catch(e){

        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);

        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);

    }


    Navigator.push(context,
        new MaterialPageRoute(builder: (context){
          return new PatientTabNavigator(index: 0,patientId: widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel);
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model)
    {
      // TODO: implement build
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new PatientTabNavigator(index: 0,patientId: widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel);
              }));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
          title: Text(
            '预约医生', style: TextStyle(fontSize: 18, color: Colors.black),),
        ),
        body: Column(
          children: <Widget>[
            DividerAppoint(text: '病人信息'),
            OneLineInfo(
              name: '姓名',
              enable: false,
              hintText: widget.name,
            ),
            OneLineInfo(
              name: '性别',
              enable: false,
              hintText: widget.gender,
            ),
            OneLineInfo(
              name: '年龄',
              enable: false,
              hintText: widget.age,
            ),
            DividerAppoint(text: '预约信息',),
            OneLineInfo(
              name: '预约时间',
              textInputFormatter: WhitelistingTextInputFormatter(
                  RegExp("[0-9-]")),
              type: TextInputType.text,
              maxLength: 10,
              func: 'patientAppReserveTime',
              hintText: 'YYYY-MM-DD',
            ),
            DividerAppoint(text: '联系人信息',),
            OneLineInfo(
              name: '电话',
              enable: false,
              hintText: widget.tel,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 150),
              child: CupertinoButton(
                  color: Colors.blueAccent,
                  child: Text('提交预约', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    //send
                    _handleAppointment(model.patientAppReserveTime);
                  }
              ),
            )
          ],
        ),
      );
    });
  }


}
class DividerAppoint extends StatelessWidget{
  DividerAppoint({Key key,this.text}) : super(key: key);
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
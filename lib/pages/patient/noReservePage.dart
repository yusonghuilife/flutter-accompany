import 'package:flutter/material.dart';
import 'package:trip/navigator/patient_tab_navigator.dart';
class NoReservePage extends StatefulWidget{
  NoReservePage({Key key,this.patientId,this.name,this.gender,this.age,this.tel}):super(key:key);
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _NoReservePage createState() {
    // TODO: implement createState
    return _NoReservePage();
  }
//  NoReservePage

}

class _NoReservePage extends State<NoReservePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('查看预约',style: TextStyle(color: Colors.black),),
        leading: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.arrow_back_ios),

          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientTabNavigator(index: 0,patientId: widget.patientId,name: widget.name,gender: widget.gender,age: widget.age,tel: widget.tel,);}));
          },
        ),
      ),
      body: Center(
        child: Text('您没有未完成的预约。\r\n您可以选择去提交一个预约。',textAlign: TextAlign.center,),
      ),
    );
  }

}
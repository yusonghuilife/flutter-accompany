import 'package:flutter/material.dart';
import 'package:trip/pages/alert/doctor_alert.dart';
class PatientAlert extends StatefulWidget{
  PatientAlert({Key key,this.tel,this.id,this.pass}):super(key:key);
  final String tel;
  final String id;
  final String pass;
  @override
  _PatientAlertState createState() => _PatientAlertState();

}

class _PatientAlertState extends State<PatientAlert> {
  var alert = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alert.add({'hello':'hello'});
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Text('病人警报',style: TextStyle(fontSize: 18),),
          ),
          Container(
            height: 500,
            child: ListView.builder(itemCount: alert.length,itemBuilder: (context,index){
//              print(alert.length);
              return AlertInfo(bgColor: Color(0xFFEF5757),textColor: Color(0xFF69141E),tel: widget.tel,id: widget.id,pass: widget.pass,);
            }),
          )
        ],
      )
    );
  }

}

class DividerWithChosenColor extends StatelessWidget{
  DividerWithChosenColor({Key key,this.text,this.bgColor,this.textColor}) : super(key: key);
  final String text;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 46,
      color: bgColor,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: 15
        ),
      ),
    );
  }
}

class AlertInfo extends StatelessWidget{
  AlertInfo({Key key,this.bgColor,this.textColor,this.tel,this.id,this.pass}): super(key :key);
  final Color bgColor;
  final Color textColor;
  final String tel;
  final String id;
  final String pass;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DividerWithChosenColor(text: '警报',bgColor: bgColor,textColor: textColor,),
          Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 0, 5),
                        child: Text('孙琦',style: TextStyle(fontSize: 17,),),
                      ),
                      Container(margin:EdgeInsets.fromLTRB(0, 10, 15, 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (context){return new DoctorAlert(id: id,tel: tel,pass: pass,);}));

                          },
                          child: Text('time   >',style: TextStyle(fontSize: 16,color: Color.fromARGB(100, 140, 140, 140),)),),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
                  alignment: Alignment.centerLeft,
                  child:Text('焦虑症',style: TextStyle(fontSize: 16),)
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 0, 20),
                    alignment: Alignment.centerLeft,
                    child:Text('心率过快，持续超过正常值',style: TextStyle(fontSize: 16,color: Color.fromARGB(100, 140, 140, 140)),)
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
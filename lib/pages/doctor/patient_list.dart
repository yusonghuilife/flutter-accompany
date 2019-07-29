import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/pages/doctor/add_patient.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:trip/pages/doctor/patient_reserve.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:trip/scoped_model.dart';
const APPBAR_SCROLL_OFFSET = 100;

class PatientList extends StatefulWidget{
  PatientList({Key key,this.tel,this.doctorId,this.pass}) : super(key:key);
  final String tel;
  final String doctorId;
  final String pass;
  @override
  _PatientListState createState() => _PatientListState();

}


class _PatientListState extends State<PatientList> {
  var info = [];
//  DateTime date = DateTime.parse("2019-07-20");

  _getPatientList(String name,String tel) async{
    var url = 'http://172.20.10.4:8000/treatships/search_patient/?patient_name=$name&doctor_phone=$tel';
    var response = await http.get(url);

    setState(() {
      info = json.decode(response.body);
    });
    return response;

  }


  @override
  void initState() {
    super.initState();
    _getPatientList('',widget.tel);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = new TextEditingController();
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: MediaQuery.removePadding(
            removeTop: false,
            context: context,
            child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: ListView.builder(
                      itemCount: info.length,
                      itemBuilder: (context, index) {
                        return PersonListItem(
                          name: info[index]['patient__name'],
                          msg: info[index]['patient__main_illness'],
                          dateTime: '',
                          route: 'PatientInfo',
                          item: info[index],
                          id: info[index]['patient__patient_id'],
                          doctorId: widget.doctorId,

                        );
                      },
                    ),
                  ),
                  Opacity(
                    opacity: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
//                                alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              height: 100,
                              margin: EdgeInsets.fromLTRB(15, 40, 15, 0),
//                                color: Colors.redAccent,
                              child: CupertinoTextField(
                                cursorWidth: 1.5,
                                padding: EdgeInsets.only(left: 20),
//                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                placeholder: 'search',
                                controller: _textController,
                                decoration: BoxDecoration(
                                    color: Color(0x4aC4C4C4),
//                              border: new Border.all(color: Colors.g)
                                    borderRadius: new BorderRadius.circular(8.0)
                                ),
                                placeholderStyle: new TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC4C4C4)
                                ),
                                clearButtonMode: OverlayVisibilityMode.editing,
                                textAlign: TextAlign.start,
                                //中文输入法有bug光标不会对齐
                                style: new TextStyle(
                                    fontSize: 15,
                                    color: Colors.black
                                ),
                                onEditingComplete: () {
                                  setState(() {
                                    info = [];
                                    _getPatientList(
                                        _textController.text, widget.tel);
                                  });
                                }, //---------------------------------------
                              ),
                            ),),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 50, 10, 5),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                color: Colors.black,
                              child: new CupertinoButton(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                pressedOpacity: 0.4,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) {
                                        return new AddPatient(
                                          id: widget.doctorId, pass: widget.pass,tel:widget.tel);
                                      }));
                                },
                                child: Text(
                                  '添加病人',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),)
                        ],
                      ),
                    ),
                  )
                ]
            )
        )
    );
  });
  }

}

class PersonListItem extends StatefulWidget{
  PersonListItem({Key key,@required this.name,@required this.msg,this.dateTime,this.route,this.item,this.id,this.doctorId,this.guardianId}) : super(key: key);
  final String name;
  final String msg;
  final String dateTime;
  final String route;
  final Object item;
  final String id;
  final String doctorId;
  final String guardianId;

  @override
  _PersonListItem createState() {
    return _PersonListItem();
  }

}

class _PersonListItem extends State<PersonListItem> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProjectModel>(builder: (context,child,model)
    {
      return new Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 76,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: new BoxDecoration(
            border: new Border(top: BorderSide(
                width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),
              bottom: BorderSide(
                  width: 1.0, color: Color.fromARGB(90, 207, 207, 207)),)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
                flex: 4,
                child: new Row(
                    children: <Widget>[
                      Container(
//                margin: EdgeInsets.only(right: 6),
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: new BoxDecoration(
                            color: Color(0xFFC4C4C4),
                            borderRadius: new BorderRadius.circular(50)
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.name.substring(0, 1),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      new Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              widget.msg,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFC4C4C4)
                              ),
                            ),
                          )
                        ],
                      )
                    ]
                )
            ),
            new Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 13),
                      child: Text(
                        widget.dateTime,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Container(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Colors.grey,
                          iconSize: 16,
                          onPressed: () {
//                           '67474';
                            if (widget.route == 'PatientInfo') {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                    return PatientInfo(id: widget.id,doctorId: widget.doctorId);
                                  }));
                            } else if (widget.route == 'PatientReserve') {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) {
                                    return PatientReserve(id: widget.id,doctorId: widget.doctorId,guardianId:widget.guardianId,dateTime:widget.dateTime);
                                  }));
                            } else {

                            }
                          },
                        )
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
    }

}
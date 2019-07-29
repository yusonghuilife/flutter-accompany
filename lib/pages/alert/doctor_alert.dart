import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/navigator/doctor_tab_navigator.dart';
import 'package:trip/pages/doctor/patient_info.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
class DoctorAlert extends StatefulWidget{
  DoctorAlert({Key key,this.tel,this.id,this.pass}):super(key:key);
  final String tel;
  final String id;
  final String pass;
  @override
  _DoctorAlert createState() {
    // TODO: implement createState
    return _DoctorAlert();
  }

}

class _DoctorAlert extends State<DoctorAlert> {
  Color titleColor = Colors.black;
  Color returnColor = Colors.blue;
  Color bgColor = Colors.white;
  Color buttonColor = Colors.blue;
  var markers = <Marker>[
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(30.594331217463765, 114.28321838378906),
      builder: (ctx) => Container(
        child: IconButton(
          icon: Icon(
            Icons.accessibility,
            color: Colors.red,
            size: 25,
          ),
        ),
      ),
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('病人警报',style: TextStyle(color: titleColor,fontSize: 18,fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: returnColor,),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context){return new DoctorTabNavigator(index: 0,tel: widget.tel,pass: widget.pass,id: widget.id,);}));
            },
          ),
        ),
        body: Column(
        children: <Widget>[
          Flexible(

              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(30.594331217463765, 114.28321838378906),
                  zoom: 17.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
//                    MarkerLayerOptions(markers: markers)
                  MarkerLayerOptions(markers: markers)

                ],
              )
            //map locate
          ),
          Container(
            height: 150,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: CupertinoButton(
                        child: Text('出动救护车',style: TextStyle(fontSize: 15),),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      color: buttonColor,
                      disabledColor: Colors.grey,
                      pressedOpacity: 0.8,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        onPressed: () {
                          setState(() {
                            bgColor = Colors.black;
                            returnColor = Colors.white;
                            buttonColor = Colors.grey;
                          });

                          var dialog = CupertinoAlertDialog(
                            title: Text("确定要出动救护车吗？"),
                            content: Text(
                              "将出动救护车至病人地图所在位置",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: <Widget>[
                              CupertinoButton(
                                child: Text("取消",
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);

                                  setState(() {
                                    bgColor = Colors.white;
                                    returnColor = Colors.blue;
                                    buttonColor = Colors.blue;

                                  });
                                },
                              ),
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
                      },
                     )
                    ),
                    Container(
                     child: CupertinoButton(
                      child: Text('查看病人信息',style: TextStyle(fontSize: 15),),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      color: buttonColor,
                      disabledColor: Colors.grey,
                      pressedOpacity: 0.8,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      onPressed: () {
//                        Navigator.push(context, new MaterialPageRoute(builder: (context){return new PatientInfo(id: widget.id,doctorId: ,);}));
                      },
                    ),
                   ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                    child: CupertinoButton(
                      child: Text('联系监护人',style: TextStyle(fontSize: 15),),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      color: buttonColor,
                      disabledColor: Colors.grey,
                      pressedOpacity: 0.8,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      onPressed: () {
                        setState(() {
                          bgColor = Colors.black;
                          returnColor = Colors.white;
                          buttonColor = Colors.grey;
                        });
                        var dialog = CupertinoAlertDialog(
                          title: Text("确定联系患者的监护人吗？"),
                          content: Text(
                            "将拨打${widget.tel}联系监护人",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: <Widget>[

                            CupertinoButton(
                              child: Text("取消",
                                style: TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  bgColor = Colors.white;
                                  returnColor = Colors.blue;
                                  buttonColor = Colors.blue;

                                });
                              },
                            ),
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
                        showDialog(context: context, builder: (_) => dialog);},
                    ),
                ),
                    Container(
                    child:
                    CupertinoButton(
                      child: Text('查看手环数据',style: TextStyle(fontSize: 15),),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      color: buttonColor,
                      disabledColor: Colors.grey,
                      pressedOpacity: 0.8,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      onPressed: () {

                      },
                    ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )

    );
  }

}
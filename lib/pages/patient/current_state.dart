import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trip/pages/patient/handRingData.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class CurrentState extends StatefulWidget{
  CurrentState({Key key,this.patientId,this.name,this.gender,this.age,this.tel}):super(key:key);
  final String patientId;
  final String name;
  final String gender;
  final String age;
  final String tel;
  @override
  _CurrentState createState() {
    // TODO: implement createState
    return _CurrentState();
  }

}

class _CurrentState extends State<CurrentState> {
  Color titleColor = Colors.black;
  Color returnColor = Colors.blue;
  Color bgColor = Colors.white;
  Color buttonColor = Colors.blue;
  var markers = <Marker>[
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(51.5, -0.09),
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
          title: Text('病人当前状态',style: TextStyle(color: titleColor,fontSize: 18,fontWeight: FontWeight.w500),),

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
                            child: Text('呼叫患者',style: TextStyle(fontSize: 15),),
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
                                title: Text("确定要联系患者吗？"),
                                content: Text(
                                  "联系患者，拨打电话至 ${widget.tel}",
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
                                      setState(() {
                                        bgColor = Colors.white;
                                        returnColor = Colors.blue;
                                        buttonColor = Colors.blue;

                                      });
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
                          child: Text('查看手环数据',style: TextStyle(fontSize: 15),),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          color: buttonColor,
                          disabledColor: Colors.grey,
                          pressedOpacity: 0.8,
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (context){return new HandRingData(patientId:widget.patientId,name:widget.name,gender:widget.gender,age:widget.age,tel:widget.tel);}));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )

    );
  }


}